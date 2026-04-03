# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "fixture is valid" do
    assert comments(:richard_comment).valid?
  end

  test "is invalid without body" do
    comment = comments(:richard_comment)
    comment.body = nil
    assert_not comment.valid?
    assert_includes comment.errors[:body], "can't be blank"
  end

  test "belongs to user" do
    assert_respond_to comments(:richard_comment), :user
  end

  test "belongs to post" do
    assert_respond_to comments(:richard_comment), :post
  end

  test "is destroyed when user is destroyed" do
    user = users(:richard)
    assert_difference "Comment.count", -1 do
      user.destroy
    end
  end

  test "is destroyed when post is destroyed" do
    post = posts(:published_post)
    assert_difference "Comment.count", -1 do
      post.destroy
    end
  end
end
