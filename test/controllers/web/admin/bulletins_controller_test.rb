require "test_helper"

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:john)
    @user = users(:john)
    @category = categories(:electronics)
    @bulletin = bulletins(:macbook)
  end

  test "should get index as admin" do
    sign_in(@admin)
    get admin_bulletins_path
    assert_response :success
  end

  test "should archive bulletin as admin" do
    sign_in(@admin)

    assert @bulletin.may_archive?
    patch archive_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_path
    assert_equal I18n.t("flash.bulletins.archive.success"), flash[:notice]
    @bulletin.reload
    assert @bulletin.archived?
  end

  test "should publish bulletin as admin" do
    sign_in(@admin)

    assert @bulletin.may_publish?
    patch publish_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_path
    assert_equal I18n.t("flash.bulletins.to_moderate.success"), flash[:notice]
    @bulletin.reload
    assert @bulletin.published?
  end

  test "should reject bulletin as admin" do
    sign_in(@admin)

    assert @bulletin.may_reject?
    patch reject_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_path
    assert_equal I18n.t("flash.bulletins.reject.success"), flash[:notice]
    @bulletin.reload
    assert @bulletin.rejected?
  end
end
