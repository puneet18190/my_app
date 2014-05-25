class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if session.has_key?(:facebook_data)
      @data = session[:facebook_data]
    end
  end

end
