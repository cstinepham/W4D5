class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    current_user.nil? ? false : true
  end

  def require_log_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def logout!
    session[:session_token] = nil
    current_user.reset_session_token!
    @current_user = nil
  end
end
