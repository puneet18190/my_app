class HomeController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery :except => [:send_message,:test_image]

  def index
    @user = current_user
    if session.has_key?(:facebook_data)
      @data = session[:facebook_data]
    end
  end

  def send_message
    #Pusher['private-'+params[:user_id]].trigger('new_message', {:from => current_user.email, :body => params[:message]})
    Pusher['private'].trigger('new_message', {:from => current_user.email, :body => params[:message],:user_id => params[:user_id]})
    render :json => {:status => true}
  end

  def test_image
    @user = current_user
    @user.update_attribute('avatar',params[:user][:profile_image])
    respond_to do |format|
        format.js
    end
  end

  def get_profile_data
    @user = current_user
    render :json => {:pic => @user.avatar}.to_json
  end
end
