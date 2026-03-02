require "test_helper"

class Web::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get web_users_profile_url
    assert_response :success
  end
end
