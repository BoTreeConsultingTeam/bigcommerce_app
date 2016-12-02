class OmniauthController < ApplicationController
  def index
    puts request.body.inspect
  end
end
