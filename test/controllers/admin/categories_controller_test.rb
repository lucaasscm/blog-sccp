# frozen_string_literal: true

require "test_helper"

module Admin
  class CategoriesControllerTest < ActionDispatch::IntegrationTest
    setup { sign_in_as(users(:lucas)) }

    test "index returns success" do
      get admin_categories_path
      assert_response :success
    end

    test "index redirects to login when not authenticated" do
      sign_out
      get admin_categories_path
      assert_redirected_to new_session_path
    end

    test "new returns success" do
      get new_admin_category_path
      assert_response :success
    end

    test "create saves category and redirects" do
      assert_difference "Category.count", 1 do
        post admin_categories_path, params: { category: { title: "Nova Categoria" } }
      end
      assert_redirected_to admin_categories_path
    end

    test "create with invalid params renders new" do
      post admin_categories_path, params: { category: { title: "" } }
      assert_response :unprocessable_entity
    end

    test "create with duplicate title renders new" do
      post admin_categories_path, params: { category: { title: categories(:jogos).title } }
      assert_response :unprocessable_entity
    end

    test "edit returns success" do
      get edit_admin_category_path(categories(:jogos))
      assert_response :success
    end

    test "update saves changes and redirects" do
      patch admin_category_path(categories(:jogos)), params: { category: { title: "Jogos Decisivos" } }
      assert_redirected_to admin_categories_path
      assert_equal "Jogos Decisivos", categories(:jogos).reload.title
    end

    test "update with invalid params renders edit" do
      patch admin_category_path(categories(:jogos)), params: { category: { title: "" } }
      assert_response :unprocessable_entity
    end

    test "destroy deletes category and redirects" do
      assert_difference "Category.count", -1 do
        delete admin_category_path(categories(:mercado_da_bola))
      end
      assert_redirected_to admin_categories_path
    end
  end
end
