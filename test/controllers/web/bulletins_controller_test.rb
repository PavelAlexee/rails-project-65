# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:john)
      @category = categories(:electronics)
      @published_bulletin = bulletins(:iphone)
      @draft_bulletin = bulletins(:novel)
      @valid_bulletin_params = {
        title: "Test Bulletin",
        description: "Test Description",
        category_id: @category.id
      }
      @update_bulletin_params = {
        title: "Updated Title"
      }
    end

    test "should get index" do
      get bulletins_path
      assert_response :success
    end
    test "should show published bulletin" do
      get bulletin_path(@published_bulletin)
      assert_response :success
    end

    test "should get new when authenticated" do
      sign_in(@user)
      get new_bulletin_path
      assert_response :success
    end

    test "should not get new when not authenticated" do
      get new_bulletin_path
      assert_redirected_to root_path
      assert_equal I18n.t("flash.auth_required"), flash[:alert]
    end

    test "should create bulletin when authenticated" do
      sign_in(@user)

      assert_difference("Bulletin.count", 1) do
        post bulletins_path, params: { bulletin: @valid_bulletin_params }
      end

      bulletin = Bulletin.last
      assert_redirected_to bulletin_path(bulletin)
      assert_equal I18n.t("flash.bulletins.create.success"), flash[:notice]
    end

    test "should not create bulletin when not authenticated" do
      assert_no_difference("Bulletin.count") do
        post bulletins_path, params: { bulletin: @valid_bulletin_params }
      end
      assert_redirected_to root_path
      assert_equal I18n.t("flash.auth_required"), flash[:alert]
    end

    test "should get edit when owner" do
      sign_in(@user)

      get edit_bulletin_path(@draft_bulletin)
      assert_response :success
    end

    test "should update bulletin when owner" do
      sign_in(@user)

      patch bulletin_path(@draft_bulletin), params: { bulletin: @update_bulletin_params }

      assert_redirected_to profile_path
      assert_equal I18n.t("flash.bulletins.update.success"), flash[:notice]
      @draft_bulletin.reload
      assert_equal "Updated Title", @draft_bulletin.title
    end

    test "should send bulletin to moderation" do
      sign_in(@user)

      assert @draft_bulletin.may_to_moderate?
      patch to_moderate_bulletin_path(@draft_bulletin)

      assert_redirected_to profile_path
      assert_equal I18n.t("flash.bulletins.to_moderate.success"), flash[:notice]
      @draft_bulletin.reload
      assert @draft_bulletin.under_moderation?
    end

    test "should archive bulletin" do
      sign_in(@user)

      assert @published_bulletin.may_archive?
      patch archive_bulletin_path(@published_bulletin)

      assert_redirected_to profile_path
      assert_equal I18n.t("flash.bulletins.archive.success"), flash[:notice]
      @published_bulletin.reload
      assert @published_bulletin.archived?
    end
  end
end
