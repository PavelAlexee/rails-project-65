# frozen_string_literal: true

require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @john = users(:john)
    @jane = users(:jane)
  end

  test "should get index" do
    sign_in(@jane)
    get root_path
    assert_response :success
  end

  test "should get profile" do
    sign_in(@john)
    get profile_path
    assert_response :success
    assert_select "a", "Админка"
  end

  test "should make user admin" do
    sign_in(@jane)
    assert_not @jane.admin?

    post profile_path
    assert_redirected_to profile_path

    @jane.reload
    assert @jane.admin?
  end

  test "should remove admin status" do
    sign_in(@john)
    assert @john.admin?

    delete profile_path
    assert_redirected_to profile_path

    @john.reload
    assert_not @john.admin?
  end
end
