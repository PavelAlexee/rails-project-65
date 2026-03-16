require "test_helper"

class Web::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    user = users(:john)

    sign_in(user)

    assert signed_in?, "User should be signed in"
    assert_equal user.id, session[:user_id], "Session should contain user_id"

    get profile_path

    assert_response :success
  end

  test "should redirect to root if not signed in" do
    get profile_path
    assert_response :redirect
    assert_redirected_to root_path
  end
end
