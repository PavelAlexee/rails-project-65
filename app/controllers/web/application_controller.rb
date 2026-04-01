# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  allow_browser versions: :modern
  protect_from_forgery

  helper_method :current_user
  helper_method :signed_in?

  before_action :set_test_user, if: -> { Rails.env.test? }

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def authenticate_user!
    return if signed_in?

    redirect_to root_path, alert: t('flash.auth_required')
  end

  def set_test_user
    return if session[:user_id].present?

    user = User.find_or_create_by!(email: 'test@example.com') do |u|
      u.name = 'Test User'
      u.github_uid = 'test123'
    end
    session[:user_id] = user.id
  end
end
