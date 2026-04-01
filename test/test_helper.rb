# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

OmniAuth.config.test_mode = true

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all
  end
end

ActionDispatch::IntegrationTest.class_eval do
  def sign_in(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider: 'github',
      uid: user.github_uid,
      info: {
        email: user.email,
        name: user.name
      }
    )

    get callback_auth_path('github')

    follow_redirect!

    puts "After sign_in - session user_id: #{session[:user_id]}" if ENV['DEBUG']
  end

  def signed_in?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
