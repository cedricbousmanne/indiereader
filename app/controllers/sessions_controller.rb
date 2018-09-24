class SessionsController < ApplicationController
  
  def new

  end

  def create
    @user ||= User.find_or_create_by(website: params[:session][:user][:website])
    redirect_to LoginService.new(@user).redirect_uri
  end

  def destroy
    request.env['warden'].logout
    redirect_to root_path, notice: 'Successfully logged out'
  end

  def callback
    @user = User.find_by(last_state_string: params[:state])
    if LoginService.new(@user).verified?(params[:code])
      # logged in
      request.env['warden'].set_user(@user)
      redirect_to channels_path, notice: "Successfully logged in"
    else
      # not logged in

    end
  end
end
