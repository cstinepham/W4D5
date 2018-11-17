class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(username: params[:user][:username], password: params[:user][:password])
    if user
      session[:session_token] = user.reset_session_token!
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
  end
end
