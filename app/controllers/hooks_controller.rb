# All webhooks generateed from Bigcommerce will be handled over here.
class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def order_created
    order_id = params['data']['id']
    store_hash = params['producer'].split('/').last
    store = Store.find_by(store_hash: store_hash)
    connection = prepare_connection(store, store_hash)
    CustomNotification.perform_async(order_id, store_hash, false)
    render nothing: true, status: 200
  end

  def shipment_created
    order_id =params['data']["orderId"].to_i
    store_hash = params['producer'].split('/').last
    store = Store.find_by(store_hash: store_hash)
    connection = prepare_connection(store, store_hash)
    CustomNotification.perform_async(order_id, store_hash, true)
    render nothing: true, status: 200
  end

  private

  def prepare_connection(store, store_hash)
      Bigcommerce::Connection.build( Bigcommerce::Config.new(store_hash: store_hash, client_id: ENV['BC_CLIENT_ID'],
      access_token: store.access_token)
    )
  end
end
