require "test_helper"

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
   setup do
    @admin = users(:john)
  end

  test "should get index" do
    sign_in(@admin)
    get admin_root_path
    assert_response :success
  end
end
