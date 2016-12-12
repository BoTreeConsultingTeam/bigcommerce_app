# All webhooks generateed from Bigcommerce will be handled over here.
require 'mail'
class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def order_created
    order_id = params['data']['id']
    store_hash = params['producer'].split('/').last
    store = Store.find_by(store_hash: store_hash)
    connection = prepare_connection(store, store_hash)
    available_template = current_store.active_order_created_event_template.first
    @template = available_template.present? ? available_template : Template.first
    q_body = @template.body
    vars = prepare_variable_hash(order_id, connection)
    vars.keys.each do |key|
      q_body = q_body.gsub key, vars[key]
    end
    q_subject = @template.subject
    vars.keys.each do |key|
      q_subject = q_subject.gsub key, vars[key]
    end
    send_notification_email(vars['email'],
      store.email,
      q_subject.html_safe,
      q_body.html_safe
    )
    render nothing: true, status: 201
  end

  def shipment_created
    order_id =params['data']["orderId"].to_i
    store_hash = params['producer'].split('/').last
    store = Store.find_by(store_hash: store_hash)
    connection = prepare_connection(store, store_hash)

    vars = prepare_variable_hash(order_id, connection)

    available_template = current_store.active_shipment_created_event_template.first
    @template = available_template.present? ? available_template : Template.second
    q_body = @template.body
    vars.keys.each do |key|
      q_body = q_body.gsub key, vars[key]
    end
    q_subject = @template.subject
    vars.keys.each do |key|
      q_subject = q_subject.gsub key, vars[key]
    end

    send_notification_email(vars['email'],
      store.email,
      q_subject.html_safe,
      q_body.html_safe
    )
    render nothing: true, status: 201
  end

  private

  def prepare_variable_hash(order_id, connection)
    order = Bigcommerce::Order.find(order_id, connection: connection)
    order = OpenStruct.new(order) if order
  order_products = Bigcommerce::OrderProduct.all(order_id, connection: connection)
    prepare_order_products = []
    if order_products
      order_products.each do |product|
        prepare_order_products << OpenStruct.new(product)
      end
    end
    order_products = prepare_order_products

    customer = get_customer_details(order, connection)
    shipping_addresses = get_shipping_address_details(order, connection)
    shiping_address = OpenStruct.new(shipping_addresses.first) if shipping_addresses.present?

    variables_mapping_hash = {}
    variables_mapping_hash["{{order_created_at}}"] = Date.today.to_s
    variables_mapping_hash["{{order_id}}"] = order.id.to_s
    variables_mapping_hash["{{customer_first_name}}"] = customer.first_name
    variables_mapping_hash["{{customer_last_name}}"] = customer.last_name
    variables_mapping_hash["{{shipping_address}}"] = "<span>#{shiping_address.street_1} #{shiping_address.street_2}</span><br><span>#{shiping_address.state}</span><br /><span>#{shiping_address.country}</span>"
    product_template_str = product_raw_template

    order_products_details_arr = []
    order_products.each do |product|
      original_template = product_template_str
      images = Bigcommerce::ProductImage.all(product.product_id, connection: connection)
      product_template_str = product_template_str.gsub('{{product_image_source}}', images.first[:standard_url])
      product_template_str = product_template_str.gsub("{{product_quantity}}", product.quantity.to_s)
      product_template_str = product_template_str.gsub("{{product_name}}", product.name)
      product_template_str = product_template_str.gsub("{{product_price}}", product.base_price)
      order_products_details_arr << product_template_str
      product_template_str = original_template
    end

    variables_mapping_hash["{{order_table}}"] = order_products_details_arr.join('')
    variables_mapping_hash["{{order_subtotal}}"]=   order.subtotal_inc_tax
    variables_mapping_hash["{{order_shipping_charge}}"] = order.shipping_cost_inc_tax
    variables_mapping_hash["{{order_total}}"] = order.total_inc_tax
    variables_mapping_hash["email"] = customer.email
    variables_mapping_hash
  end

  def prepare_connection(store, store_hash)
      Bigcommerce::Connection.build( Bigcommerce::Config.new(store_hash: store_hash, client_id: ENV['BC_CLIENT_ID'],
      access_token: store.access_token)
    )
  end

  def send_notification_email(email_to, email_from, email_subject, email_body)
    smtp_details = current_store.smtp_detail
    if smtp_details.present?
      delivery = smtp_details.delivery_method.to_sym
      address = smtp_details.address
      port = smtp_details.port
      domain = smtp_details.domain
      username = smtp_details.username
      password = smtp_details.password
      Mail.defaults do
         delivery_method :smtp, { :delivery_method => delivery,
                                  :address   => address,
                                  :port => port,
                                  :domain => domain,
                                  :user_name => username ,
                                  :password  => password,
                                  :authentication => 'plain',
                                  :enable_starttls_auto => true }
      end

      mail = Mail.deliver do
        to email_to
        from email_from
        subject email_subject.html_safe
        html_part do
          content_type 'text/html; charset=UTF-8'
          body email_body
        end
      end
    else
      Rails.logger.error "ERROR >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Unable to find Smtp details of this store"
    end
  end

  def product_raw_template
    <<-START
      <tr>
       <td style='width:150px;padding:16px 0 10px 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <a data-saferedirecturl='https://www.google.com/url?hl=en&amp;q=https://www.amazon.in/gp/r.html?C%3D1H6X0AT2K3AR2%26K%3DAC1H0DB3Q6BF%26R%3D1NXICTSMU7RGK%26T%3DC%26U%3Dhttp%253A%252F%252Fwww.amazon.in%252Fdp%252FB00KKLVY22%252Fref%253Dpe_386221_48200641_TE_item_image%26A%3D8UWEP2UPJ8VFS574JIXZ6MIUMGYA%26H%3DAVMNHANDIJWU4XMFNAJ28PAA9T8A%26ref_%3Dpe_386221_48200641_TE_item_image&amp;source=gmail&amp;ust=1481170866938000&amp;usg=AFQjCNFUNU4Qv2LwAuRcJWwEw_snaS8KBw' target='_blank' style='text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' title='B00KKLVY22' href='https://www.amazon.in/gp/r.html?C=1H6X0AT2K3AR2&amp;K=AC1H0DB3Q6BF&amp;R=1NXICTSMU7RGK&amp;T=C&amp;U=http%3A%2F%2Fwww.amazon.in%2Fdp%2FB00KKLVY22%2Fref%3Dpe_386221_48200641_TE_item_image&amp;A=8UWEP2UPJ8VFS574JIXZ6MIUMGYA&amp;H=AVMNHANDIJWU4XMFNAJ28PAA9T8A&amp;ref_=pe_386221_48200641_TE_item_image'> <img style='border:0' src='{{product_image_source}}' class='CToWUd'> </a> </td>
       <td style='color:rgb(102,102,102);padding:10px 10 0 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <a data-saferedirecturl='https://www.google.com/url?hl=en&amp;q=https://www.amazon.in/gp/r.html?C%3D1H6X0AT2K3AR2%26K%3DAC1H0DB3Q6BF%26R%3D1NXICTSMU7RGK%26T%3DC%26U%3Dhttp%253A%252F%252Fwww.amazon.in%252Fdp%252FB00KKLVY22%252Fref%253Dpe_386221_48200641_TE_item%26A%3DQAZVHKQZEUDP2EUYEF6VNAYSEE0A%26H%3DNZAAHUYVBNDH7H17H7Q7XAZZX9WA%26ref_%3Dpe_386221_48200641_TE_item&amp;source=gmail&amp;ust=1481170866938000&amp;usg=AFQjCNHqy3_6mbzV6tyFmlhRKdoVyHDAtQ' target='_blank' style='text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='https://www.amazon.in/gp/r.html?C=1H6X0AT2K3AR2&amp;K=AC1H0DB3Q6BF&amp;R=1NXICTSMU7RGK&amp;T=C&amp;U=http%3A%2F%2Fwww.amazon.in%2Fdp%2FB00KKLVY22%2Fref%3Dpe_386221_48200641_TE_item&amp;A=QAZVHKQZEUDP2EUYEF6VNAYSEE0A&amp;H=NZAAHUYVBNDH7H17H7Q7XAZZX9WA&amp;ref_=pe_386221_48200641_TE_item'> <b>{{product_quantity}} x </b>{{product_name}} </a>
       </td>
       <td style='width:110px;text-align:right;font-size:14px;padding:10px 10px 0 0;vertical-align:top;line-height:18px;font-family:Arial,sans-serif'> <strong> {{product_price}} </strong> <br> </td>
      </tr>
    START
  end

  def get_customer_details(order, connection)
    Bigcommerce::Customer.find(order.customer_id, connection: connection)
  end

  def get_shipping_address_details(order, connection)
    Bigcommerce::OrderShippingAddress.all(order.id, connection: connection)
  end
end
