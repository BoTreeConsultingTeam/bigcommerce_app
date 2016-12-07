# All webhooks generateed from Bigcommerce will be handled over here.
require 'mail'
class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def order_created
    puts "#{params} PARAMS"

    order_id = params['data']['id']
    store_hash = params['producer'].split('/').last
    store = Store.find_by(store_hash: store_hash)

    connection = Bigcommerce::Connection.build(
      Bigcommerce::Config.new(store_hash: store_hash, client_id: ENV['BC_CLIENT_ID'],
      access_token: store.access_token)
    )

    order = Bigcommerce::Order.find(order_id, connection: connection)

    if order
      @order = OpenStruct.new(order)
    else
      redirect_to root_path and return
    end

    puts "========================ORDER DETAILS=============================="
    puts "#{@order}"
    puts "======================================================"

    order_products = Bigcommerce::OrderProduct.all(order_id, connection: connection)

    # Bigcommerce::ProductImage.all(112, connection: connection) ccan be used to get product images
    @order_products = []
    if order_products
      order_products.each do |product|
        @order_products << OpenStruct.new(product)
      end
    else
      redirect_to root_path and return
    end

    puts "======================PRODUCT DETAILS================================"
    puts "#{@order_products}"

    @customer = Bigcommerce::Customer.find(@order.customer_id, connection: connection)

    puts "======================CUSTOMER DETAILS================================"
    puts "#{@customer}"

    shipping_addresses = Bigcommerce::OrderShippingAddress.all(@order.id, connection: connection)

    @shiping_address = OpenStruct.new(shipping_addresses.first)
    puts "======================Shipping Address  DETAILS================================"
    puts "#{@shiping_address}"

    var_hash = prepare_variable_hash(@order, @order_products, @customer, @shiping_address,connection)
    Mail.defaults do
      delivery_method :smtp, {
                    :delivery_method => :smtp,
          :address   => "smtp.sendgrid.net",
                                 :port      => 587,
                               :domain    => "https://mysterious-citadel-27744.herokuapp.com/",
                               :user_name => "#{ENV['SENDGRID_USERNAME']}",
                               :password  => "#{ENV['SENDGRID_PASSWORD']}",
                               :authentication => 'plain',
                               :enable_starttls_auto => true }
    end
    @template = Template.last
    tempale_body = @template.body
    vars = var_hash
    q_body = tempale_body
    vars.keys.each do |key|
      q_body = q_body.gsub key, vars[key]
    end

    q_subject = @template.subject
    vars.keys.each do |key|
      q_subject = q_subject.gsub key, vars[key]
    end

    mail = Mail.deliver do
      to 'nishantupadhyay@botreetechnologies.com'
      from 'big.commercedemo123@gmail.com'
      subject q_subject.html_safe
      text_part do
        body q_body.html_safe
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body q_body.html_safe
      end
    end
    render nothing: true, status: 200
  end

  def shipment_created
    # write code to handle logic after webhook of shipment creation is called
    render nothing: true, status: 200
  end

  private

  def prepare_variable_hash(order, order_products, customer, shiping_address, connection)
    h = {}
    h["%%ORDER_created_at%%"] = Date.today.to_s
    h["%%ORDER_id%%"] = order.id.to_s
    h["%%CUSTOMER_first_name%%"] = customer.first_name
    h["%%CUSTOMER_last_name%%"] = customer.last_name
    h["%%SHIPPING_address%%"] = "<span>#{shiping_address.street_1} #{shiping_address.street_2}</span><br><span>#{shiping_address.state}</span><br /><span>#{shiping_address.country}</span>"
    product_template_str = <<-START
      <tr>
       <td style='width:150px;text-align:center;padding:16px 0 10px 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' class='m_-8458387270647573780m_-8456204030309822964m_4722856042003582080m_-5527024756179962845photo'> <a data-saferedirecturl='https://www.google.com/url?hl=en&amp;q=https://www.amazon.in/gp/r.html?C%3D1H6X0AT2K3AR2%26K%3DAC1H0DB3Q6BF%26R%3D1NXICTSMU7RGK%26T%3DC%26U%3Dhttp%253A%252F%252Fwww.amazon.in%252Fdp%252FB00KKLVY22%252Fref%253Dpe_386221_48200641_TE_item_image%26A%3D8UWEP2UPJ8VFS574JIXZ6MIUMGYA%26H%3DAVMNHANDIJWU4XMFNAJ28PAA9T8A%26ref_%3Dpe_386221_48200641_TE_item_image&amp;source=gmail&amp;ust=1481170866938000&amp;usg=AFQjCNFUNU4Qv2LwAuRcJWwEw_snaS8KBw' target='_blank' style='text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' title='B00KKLVY22' href='https://www.amazon.in/gp/r.html?C=1H6X0AT2K3AR2&amp;K=AC1H0DB3Q6BF&amp;R=1NXICTSMU7RGK&amp;T=C&amp;U=http%3A%2F%2Fwww.amazon.in%2Fdp%2FB00KKLVY22%2Fref%3Dpe_386221_48200641_TE_item_image&amp;A=8UWEP2UPJ8VFS574JIXZ6MIUMGYA&amp;H=AVMNHANDIJWU4XMFNAJ28PAA9T8A&amp;ref_=pe_386221_48200641_TE_item_image'> <img style='border:0' src='%%PRODUCT_image_source%%' class='CToWUd'> </a> </td>
       <td style='color:rgb(102,102,102);padding:10px 0 0 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' class='m_-8458387270647573780m_-8456204030309822964m_4722856042003582080m_-5527024756179962845name'> <a data-saferedirecturl='https://www.google.com/url?hl=en&amp;q=https://www.amazon.in/gp/r.html?C%3D1H6X0AT2K3AR2%26K%3DAC1H0DB3Q6BF%26R%3D1NXICTSMU7RGK%26T%3DC%26U%3Dhttp%253A%252F%252Fwww.amazon.in%252Fdp%252FB00KKLVY22%252Fref%253Dpe_386221_48200641_TE_item%26A%3DQAZVHKQZEUDP2EUYEF6VNAYSEE0A%26H%3DNZAAHUYVBNDH7H17H7Q7XAZZX9WA%26ref_%3Dpe_386221_48200641_TE_item&amp;source=gmail&amp;ust=1481170866938000&amp;usg=AFQjCNHqy3_6mbzV6tyFmlhRKdoVyHDAtQ' target='_blank' style='text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='https://www.amazon.in/gp/r.html?C=1H6X0AT2K3AR2&amp;K=AC1H0DB3Q6BF&amp;R=1NXICTSMU7RGK&amp;T=C&amp;U=http%3A%2F%2Fwww.amazon.in%2Fdp%2FB00KKLVY22%2Fref%3Dpe_386221_48200641_TE_item&amp;A=QAZVHKQZEUDP2EUYEF6VNAYSEE0A&amp;H=NZAAHUYVBNDH7H17H7Q7XAZZX9WA&amp;ref_=pe_386221_48200641_TE_item'> <b>%%PRODUCT_quantity%% x </b>%%PRODUCT_name%% </a>
       </td>
       <td style='width:110px;text-align:right;font-size:14px;padding:10px 10px 0 0;vertical-align:top;line-height:18px;font-family:Arial,sans-serif' class='m_-8458387270647573780m_-8456204030309822964m_4722856042003582080m_-5527024756179962845price'> <strong> %%PRODUCT_price%% </strong> <br> </td>
      </tr>
    START
    st = ''
    order_products.each do |product|
      images = Bigcommerce::ProductImage.all(product.product_id, connection: connection)
      product_template_str = product_template_str.gsub('%%PRODUCT_image_source%%', images.first[:standard_url])
      product_template_str = product_template_str.gsub("%%PRODUCT_quantity%%", product.quantity.to_s)
      product_template_str = product_template_str.gsub("%%PRODUCT_name%%", product.name)
      product_template_str = product_template_str.gsub("%%PRODUCT_price%%", product.base_price)
      st += product_template_str
    end
    h["%%ORDER_table%%"] = st
    h["%%ORDER_subtotal%%"]=   order.subtotal_inc_tax
    h["%%ORDER_shipping_charge%%"] = order.shipping_cost_inc_tax
    h["%%ORDER_total%%"] = order.total_inc_tax
    h
  end
end
