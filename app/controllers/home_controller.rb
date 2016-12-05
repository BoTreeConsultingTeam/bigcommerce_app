class HomeController < ApplicationController
  def index
  end

  private

  # def current_user
  #   return nil unless session[:user_id]
  #   User.get(session[:user_id])
  # end

  def current_store
    stores.where(id: session[:store_id]).first
  end

  def bc_api
    config = {
      store_hash: self.store_hash,
      client_id: bc_client_id,
      access_token: self.access_token
    }
    Bigcommerce::Api.new(config)
  end

  def bc_api_working?
    time = bc_api.time
    time && time.key?("time")
  end
end
