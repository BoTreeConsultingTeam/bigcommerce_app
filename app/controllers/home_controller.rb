class HomeController < ApplicationController
  def index
    # @user = current_user
    # @store = current_store
    # return render_error('[home] Unauthorized!') unless @user && @store
    #
    # @bc_api_url = bc_api_url
    # @client_id = bc_client_id
    # @products = JSON.pretty_generate(@store.bc_api.products)

  end

  private

  # def current_user
  #   return nil unless session[:user_id]
  #   User.get(session[:user_id])
  # end

  def current_store
    user = current_user
    return nil unless user
    return nil unless session[:store_id]
    user.stores.get(session[:store_id])
  end
end
