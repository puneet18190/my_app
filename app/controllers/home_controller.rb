class HomeController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery :except => :send_message

  def index
    if session.has_key?(:facebook_data)
      @data = session[:facebook_data]
    end
  end

  def send_message
    #Pusher['private-'+params[:user_id]].trigger('new_message', {:from => current_user.email, :body => params[:message]})
    Pusher['private'].trigger('new_message', {:from => current_user.email, :body => params[:message]})
    render :json => {:status => true}
  end

end
