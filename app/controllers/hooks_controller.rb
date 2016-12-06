# All hooks from Bigcommerce will be handled over here.
class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def order_created
    # write code to handle logic after webhook of order is called
    render nothing: true, status: 200
  end

  def shipment_created
    # write code to handle logic after webhook of shipment creation is called
    render nothing: true, status: 200
  end
end
