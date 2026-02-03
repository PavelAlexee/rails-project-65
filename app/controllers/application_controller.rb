class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  protect_from_forgery

  helper_method :current_user


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end
end
