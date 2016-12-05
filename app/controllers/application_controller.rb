class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_header_for_iframe
  helper_method :current_store

  private

  def set_header_for_iframe
    response.headers.delete "X-Frame-Options"
  end

  def current_store
    puts "params >>>>>>>>>>>>>>>>>>>>>>> #{params}"
    @current_store = Store.find(session[:store_id])
  end
end
