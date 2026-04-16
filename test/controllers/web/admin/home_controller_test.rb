# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      test 'should get index' do
        get web_admin_home_index_url
        assert_response :success
      end
    end
  end
end
