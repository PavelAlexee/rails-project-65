# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:john)
    @category = categories(:electronics)
    @empty_category = categories(:automotive)
  end

  test 'should get index' do
    sign_in(@admin)
    get admin_categories_path
    assert_response :success
  end

  test 'should get new' do
    sign_in(@admin)
    get new_admin_category_path
    assert_response :success
  end

  test 'should create category' do
    sign_in(@admin)
    assert_difference('Category.count', 1) do
      post admin_categories_path, params: { category: { name: 'New Category' } }
    end
    assert_redirected_to admin_categories_path
    assert_equal I18n.t('flash.admin.categories.create.success'), flash[:notice]
  end

  test 'should get edit' do
    sign_in(@admin)
    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'should update category' do
    sign_in(@admin)
    patch admin_category_path(@category), params: { category: { name: 'Updated Name' } }
    assert_redirected_to admin_categories_path
    assert_equal I18n.t('flash.admin.categories.update.success'), flash[:notice]
    @category.reload
    assert_equal 'Updated Name', @category.name
  end

  test 'should destroy category' do
    sign_in(@admin)

    assert_difference('Category.count', -1) do
      delete admin_category_path(@empty_category)
    end
    assert_redirected_to admin_categories_path
    assert_equal I18n.t('flash.admin.categories.destroy.success'), flash[:notice]
  end
end
