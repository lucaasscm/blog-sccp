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

  test "edit renders form for comment owner" do
    sign_in_as(users(:richard))

    get edit_post_comment_path(posts(:published_post), comments(:richard_comment))

    assert_response :ok
  end

  test "edit redirects non-owner with alert" do
    sign_in_as(users(:joel))

    get edit_post_comment_path(posts(:published_post), comments(:richard_comment))

    assert_redirected_to post_path(posts(:published_post))
    assert_equal "Você não tem permissão para isso.", flash[:alert]
  end

  test "edit redirects to login when not authenticated" do
    get edit_post_comment_path(posts(:published_post), comments(:richard_comment))

    assert_redirected_to new_session_path
  end

  test "update changes comment body for owner" do
    sign_in_as(users(:richard))

    patch post_comment_path(posts(:published_post), comments(:richard_comment)),
          params: { comment: { body: "Novo texto do comentário" } }

    assert_equal "Novo texto do comentário", comments(:richard_comment).reload.body
    assert_redirected_to post_path(posts(:published_post))
  end

  test "update redirects non-owner with alert" do
    sign_in_as(users(:joel))

    patch post_comment_path(posts(:published_post), comments(:richard_comment)),
          params: { comment: { body: "Texto alterado indevidamente" } }

    assert_redirected_to post_path(posts(:published_post))
    assert_equal "Você não tem permissão para isso.", flash[:alert]
  end

  test "update does not change comment when non-owner tries" do
    sign_in_as(users(:joel))
    original_body = comments(:richard_comment).body

    patch post_comment_path(posts(:published_post), comments(:richard_comment)),
          params: { comment: { body: "Texto alterado indevidamente" } }

    assert_equal original_body, comments(:richard_comment).reload.body
  end

  test "update redirects to login when not authenticated" do
    patch post_comment_path(posts(:published_post), comments(:richard_comment)),
          params: { comment: { body: "Texto" } }

    assert_redirected_to new_session_path
  end

  test "destroy removes comment for owner" do
    sign_in_as(users(:richard))

    assert_difference "Comment.count", -1 do
      delete post_comment_path(posts(:published_post), comments(:richard_comment))
    end
  end

  test "destroy returns turbo stream removing comment frame for owner" do
    sign_in_as(users(:richard))

    delete post_comment_path(posts(:published_post), comments(:richard_comment)),
           headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :ok
    assert_includes response.body, "comment_#{comments(:richard_comment).id}"
    assert_includes response.body, "remove"
  end

  test "destroy redirects non-owner with alert" do
    sign_in_as(users(:joel))

    assert_no_difference "Comment.count" do
      delete post_comment_path(posts(:published_post), comments(:richard_comment))
    end

    assert_redirected_to post_path(posts(:published_post))
    assert_equal "Você não tem permissão para isso.", flash[:alert]
  end

  test "destroy redirects to login when not authenticated" do
    delete post_comment_path(posts(:published_post), comments(:richard_comment))

    assert_redirected_to new_session_path
  end

  test "admin can destroy any comment" do
    sign_in_as(users(:lucas))

    assert_difference "Comment.count", -1 do
      delete post_comment_path(posts(:published_post), comments(:richard_comment))
    end
  end
end
