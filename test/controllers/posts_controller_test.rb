# frozen_string_literal: true

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "index returns success" do
    get posts_path
    assert_response :success
  end

  test "index is accessible without authentication" do
    get posts_path
    assert_response :success
  end

  test "show returns success for published post" do
    get post_path(posts(:published_post))
    assert_response :success
  end

  test "show is accessible without authentication" do
    get post_path(posts(:published_post))
    assert_response :success
  end

  test "show returns 404 for draft post" do
    get post_path(posts(:draft_post))
    assert_response :not_found
  end
end
