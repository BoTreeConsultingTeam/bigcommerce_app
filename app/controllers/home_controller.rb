class HomeController < ApplicationController
  layout false, only: :default_template
  def index
  end

  def default_template
    @order = OpenStruct.new(static_hash)
    @customer = OpenStruct.new({
        first_name: 'Nishant',
        last_name: 'Upadhyay'
    })
    render :layout => false
  end

  def default_shipment_template
    render :layout => false
  end

  private

  #Get last order of your store - Bigcommerce::Order.all(connection: connection).last
  def static_hash
    {:id=>144,
      :customer_id=>1,
      :date_created=>"Wed, 07 Dec 2016 06:13:56 +0000",
      :date_modified=>"Wed, 07 Dec 2016 06:14:12 +0000",
      :date_shipped=>"",
      :status_id=>11,
      :status=>"Awaiting Fulfillment",
      :subtotal_ex_tax=>"1.0000",
      :subtotal_inc_tax=>"1.0000",
      :subtotal_tax=>"0.0000",
      :base_shipping_cost=>"0.0000",
      :shipping_cost_ex_tax=>"0.0000",
      :shipping_cost_inc_tax=>"0.0000",
      :shipping_cost_tax=>"0.0000",
      :shipping_cost_tax_class_id=>2,
      :base_handling_cost=>"0.0000",
      :handling_cost_ex_tax=>"0.0000",
      :handling_cost_inc_tax=>"0.0000",
      :handling_cost_tax=>"0.0000",
      :handling_cost_tax_class_id=>2,
      :base_wrapping_cost=>"0.0000",
      :wrapping_cost_ex_tax=>"0.0000",
      :wrapping_cost_inc_tax=>"0.0000",
      :wrapping_cost_tax=>"0.0000",
      :wrapping_cost_tax_class_id=>3,
      :total_ex_tax=>"1.0000",
      :total_inc_tax=>"1.0000",
      :total_tax=>"0.0000",
      :items_total=>1,
      :items_shipped=>0,
      :payment_method=>"Test Payment Gateway",
      :payment_provider_id=>"",
      :payment_status=>"captured",
      :refunded_amount=>"0.0000",
      :order_is_digital=>false,
      :store_credit_amount=>"0.0000",
      :gift_certificate_amount=>"0.0000",
      :ip_address=>"203.88.147.114",
      :geoip_country=>"India",
      :geoip_country_iso2=>"IN",
      :currency_id=>1,
      :currency_code=>"INR",
      :currency_exchange_rate=>"1.0000000000",
      :default_currency_id=>1,
      :default_currency_code=>"INR",
      :staff_notes=>"",
      :customer_message=>"",
      :discount_amount=>"0.0000",
      :coupon_discount=>"0.0000",
      :shipping_address_count=>1,
      :is_deleted=>false,
      :ebay_order_id=>"0",
      :billing_address=>
       {:first_name=>"nishant",
        :last_name=>"upadhyay",
        :company=>"botree",
        :street_1=>"Sola",
        :street_2=>"Gota",
        :city=>"Ahmedabad",
        :state=>"Gujarat",
        :zip=>"380060",
        :country=>"India",
        :country_iso2=>"IN",
        :phone=>"7801829429",
        :email=>"nishantupadhyay@botreetechnologies.com",
        :form_fields=>[]},
      :is_email_opt_in=>false,
      :credit_card_type=>nil,
      :order_source=>"www",
      :external_source=>nil,
      :products=>{:url=>"https://api.bigcommerce.com/stores/kddaechy/v2/orders/144/products", :resource=>"/orders/144/products"},
      :shipping_addresses=>
       {:url=>"https://api.bigcommerce.com/stores/kddaechy/v2/orders/144/shippingaddresses", :resource=>"/orders/144/shippingaddresses"},
      :coupons=>{:url=>"https://api.bigcommerce.com/stores/kddaechy/v2/orders/144/coupons", :resource=>"/orders/144/coupons"}}
  end

  def product_images
    # 112 is product id
    # Bigcommerce::ProductImage.all(112, connection: connection)
    # standard_url field to display image
        [{:id=>376,
      :product_id=>112,
      :image_file=>"x/859/classes__26585.jpg",
      :zoom_url=>"http://cdn6.bigcommerce.com/s-kddaechy/products/112/images/376/classes__26585.1481095566.1280.1280.jpg?c=2",
      :thumbnail_url=>"http://cdn6.bigcommerce.com/s-kddaechy/products/112/images/376/classes__26585.1481095566.500.750.jpg?c=2",
      :standard_url=>"http://cdn6.bigcommerce.com/s-kddaechy/products/112/images/376/classes__26585.1481095566.190.285.jpg?c=2",
      :tiny_url=>"http://cdn6.bigcommerce.com/s-kddaechy/products/112/images/376/classes__26585.1481095566.60.90.jpg?c=2",
      :is_thumbnail=>true,
      :sort_order=>0,
      :description=>"Test image for product",
      :date_created=>"Wed, 07 Dec 2016 07:26:06 +0000",
      :is_sample=>false}]
  end
end
