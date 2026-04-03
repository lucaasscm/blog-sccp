# frozen_string_literal: true

require "test_helper"

module Admin
  class PostsControllerTest < ActionDispatch::IntegrationTest
    setup { sign_in_as(users(:lucas)) }

    test "index returns success" do
      get admin_posts_path, as: :json
      assert_response :success
    end

    test "index redirects to login when not authenticated" do
      sign_out
      get admin_posts_path
      assert_redirected_to new_session_path
    end

    test "new returns success" do
      get new_admin_post_path, as: :json
      assert_response :success
    end

    test "create saves post and redirects" do
      assert_difference "Post.count", 1 do
        post admin_posts_path, params: { post: valid_post_params }
      end
      assert_redirected_to admin_posts_path
    end

    test "create associates post with current user" do
      post admin_posts_path, params: { post: valid_post_params }
      assert_equal users(:lucas), Post.order(:id).last.user
    end

    test "create with invalid params renders new" do
      post admin_posts_path, params: { post: valid_post_params.merge(title: "") }, as: :json
      assert_response :unprocessable_entity
    end

    test "edit returns success" do
      get edit_admin_post_path(posts(:published_post)), as: :json
      assert_response :success
    end

    test "update saves changes and redirects" do
      patch admin_post_path(posts(:published_post)), params: { post: { title: "Novo título" } }
      assert_redirected_to admin_posts_path
      assert_equal "Novo título", posts(:published_post).reload.title
    end

    test "update with invalid params renders edit" do
      patch admin_post_path(posts(:published_post)), params: { post: { title: "" } }, as: :json
      assert_response :unprocessable_entity
    end

    test "destroy deletes post and redirects" do
      assert_difference "Post.count", -1 do
        delete admin_post_path(posts(:published_post))
      end
      assert_redirected_to admin_posts_path
    end

    test "destroy redirects to login when not authenticated" do
      sign_out
      delete admin_post_path(posts(:published_post))
      assert_redirected_to new_session_path
    end

    private

    def valid_post_params
      {
        title: "Corinthians na Libertadores",
        content: "O Timão está de volta.",
        status: "draft",
        category_id: categories(:jogos).id
      }
    end
  end
end
