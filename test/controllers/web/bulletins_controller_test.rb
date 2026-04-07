# frozen_string_literal: true

require "test_helper"

class Web::BulletinsinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @category = categories(:electronics)
    @published_bulletin = bulletins(:iphone)
    @draft_bulletin = bulletins(:macbook)
  end

  test "should get index" do
    get bulletins_path
    assert_response :success
  end
  test "should show published bulletin" do
    published_bulletin = Bulletin.create!(
      title: "Published Bulletin",
      description: "Test Description",
      category: @category,
      user: @user,
      state: :published
    )

    get bulletin_path(published_bulletin)
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
      post bulletins_path, params: {
        bulletin: {
          title: "Test Bulletin",
          description: "Test Description",
          category_id: @category.id
        }
      }
    end

    bulletin = Bulletin.last
    assert_redirected_to bulletin_path(bulletin)
    assert_equal I18n.t("flash.bulletins.create.success"), flash[:notice]
  end

  test "should not create bulletin when not authenticated" do
    assert_no_difference("Bulletin.count") do
      post bulletins_path, params: {
        bulletin: {
          title: "Test Bulletin",
          description: "Test Description",
          category_id: @category.id
        }
      }
    end
    assert_redirected_to root_path
    assert_equal I18n.t("flash.auth_required"), flash[:alert]
  end

  # Тест для edit
  test "should get edit when owner" do
    sign_in(@user)
    bulletin = Bulletin.create!(
      title: "My Bulletin",
      description: "My Description",
      category: @category,
      user: @user,
      state: :draft
    )

    get edit_bulletin_path(bulletin)
    assert_response :success
  end

  test "should update bulletin when owner" do
    sign_in(@user)
    bulletin = Bulletin.create!(
      title: "Original Title",
      description: "Original Description",
      category: @category,
      user: @user,
      state: :draft
    )

    patch bulletin_path(bulletin), params: {
      bulletin: {
        title: "Updated Title"
      }
    }

    assert_redirected_to profile_path
    assert_equal I18n.t("flash.bulletins.update.success"), flash[:notice]
    bulletin.reload
    assert_equal "Updated Title", bulletin.title
  end

  test "should send bulletin to moderation" do
    sign_in(@user)
    bulletin = Bulletin.create!(
      title: "Draft Bulletin",
      description: "Draft Description",
      category: @category,
      user: @user,
      state: :draft
    )

    assert bulletin.may_to_moderate?
    patch to_moderate_bulletin_path(bulletin)

    assert_redirected_to profile_path
    assert_equal I18n.t("flash.bulletins.to_moderate.success"), flash[:notice]
    bulletin.reload
    assert bulletin.under_moderation?
  end

  test "should archive bulletin" do
    sign_in(@user)
    bulletin = Bulletin.create!(
      title: "Active Bulletin",
      description: "Active Description",
      category: @category,
      user: @user,
      state: :published
    )

    assert bulletin.may_archive?
    patch archive_bulletin_path(bulletin)

    assert_redirected_to profile_path
    assert_equal I18n.t("flash.bulletins.archive.success"), flash[:notice]
    bulletin.reload
    assert bulletin.archived?
  end
end
