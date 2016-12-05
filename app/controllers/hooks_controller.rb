class HooksController < ApplicationController
  def order_created
    puts "Hello There Order just created >>>>>>>>>>>>>>>>>>> "
    render nothing: true, status: 200
  end

  def shipment_created
    puts "Hello There Shipment just created >>>>>>>>>>>>>>>>>>> "
    render nothing: true, status: 200
  end
end
