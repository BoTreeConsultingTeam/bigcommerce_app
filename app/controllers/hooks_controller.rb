class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_hooks_access
  def check_hooks_access
    if request.headers['X-Hooks-Auth-Header'] != 'superSecretAuthToken'
      render :file => 'public/401.html', :status => :unauthorized, :layout => false
    end
  end

  def order_created
    puts 'Your order has been created!'
    puts params.inspect
    Notifier.order_notifier(current_store.username, current_store.email).deliver
  end

  def shipment_created
    puts 'Your shipment has been created!'
    puts params.inspect
    Notifier.shipment_notifier(current_store.username, current_store.email).deliver
  end
end
