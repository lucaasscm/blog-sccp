# frozen_string_literal: true

require "test_helper"

module Admin
  class CommentsControllerTest < ActionDispatch::IntegrationTest
    setup { sign_in_as(users(:lucas)) }

    test "index returns success" do
      get admin_comments_path
      assert_response :success
    end

    test "index redirects to login when not authenticated" do
      sign_out
      get admin_comments_path
      assert_redirected_to new_session_path
    end

    test "destroy deletes comment and redirects" do
      assert_difference "Comment.count", -1 do
        delete admin_comment_path(comments(:richard_comment))
      end
      assert_redirected_to admin_comments_path
    end

    test "destroy redirects to login when not authenticated" do
      sign_out
      delete admin_comment_path(comments(:richard_comment))
      assert_redirected_to new_session_path
    end
  end
end
