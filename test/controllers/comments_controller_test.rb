# frozen_string_literal: true

require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "create redirects to login when not authenticated" do
    post post_comments_path(posts(:published_post)), params: { comment: { body: "Vai Corinthians!" } }
    assert_redirected_to new_session_path
  end

  test "create saves comment when authenticated" do
    sign_in_as(users(:lucas))

    assert_difference "Comment.count", 1 do
      post post_comments_path(posts(:published_post)), params: { comment: { body: "Vai Corinthians!" } }
    end

    assert_redirected_to post_path(posts(:published_post))
  end

  test "create associates comment with current user" do
    sign_in_as(users(:lucas))

    post post_comments_path(posts(:published_post)), params: { comment: { body: "Vai Corinthians!" } }

    assert_equal users(:lucas), Comment.order(:id).last.user
  end

  test "create does not save comment with blank body" do
    sign_in_as(users(:lucas))

    assert_no_difference "Comment.count" do
      post post_comments_path(posts(:published_post)), params: { comment: { body: "" } }
    end

    assert_redirected_to post_path(posts(:published_post))
  end

  test "create returns 404 for draft post" do
    sign_in_as(users(:lucas))

    post post_comments_path(posts(:draft_post)), params: { comment: { body: "Vai Corinthians!" } }
    assert_response :not_found
  end
end
