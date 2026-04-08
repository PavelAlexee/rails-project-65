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

class ActionDispatch::IntegrationTest
  setup do
    host! 'localhost'
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end
end
