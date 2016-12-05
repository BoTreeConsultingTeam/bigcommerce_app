class HomeController < ApplicationController
  def index
    
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
