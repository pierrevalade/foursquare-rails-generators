class UsersController < ApplicationController
  def new
    render text: "<a href='#{new_foursquare_client_path}'><img src='https://playfoursquare.s3.amazonaws.com/press/logo/connect-black.png' /></a>"
  end

  def show
    render text: "hello #{current_user.name}"
  end

  private
  def current_user
    @current_user ||= FoursquareUser.find(session[:user_id])
  end
end