class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  helper_method :current_user

  def login!(user)
    session[user.id][:session_token] = user.session_token
  end

  def logout!
    current_user.reset_session_token!
    session[current_user.id][:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_logged_out
    redirect_to cats_url if logged_in?
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

end
