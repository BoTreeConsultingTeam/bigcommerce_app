class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # before_filter :check_hooks_access

  def check_hooks_access
    if request.headers['X-Hooks-Auth-Header'] != 'superSecretAuthToken'
      render :file => 'public/401.html', :status => :unauthorized, :layout => false
    end
  end

  def order_created
    # Rails.logger.debug ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CAlling order created"
    # begin
    #   Notifier.order_notifier(current_store.username, current_store.email).deliver_now
    # rescue Exception => e
    #   Rails.logger.debug "EXCEPTION >>>>>>>>>>>>>>>>>>>>>>>> + #{e}"
    # end
    # Rails.logger.debug 'Your order has been created!'
    # Rails.logger.debug params.inspect
    EmailType.create(name: "abc")
    render nothing: true, status: 200
  end

  def shipment_created
    puts 'Your shipment has been created!'
    puts params.inspect
    Notifier.shipment_notifier(current_store.username, current_store.email).deliver_now
  end
end
