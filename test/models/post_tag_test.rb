# frozen_string_literal: true

require "test_helper"

class PostTagTest < ActiveSupport::TestCase
  test "is valid with all required attributes" do
    post_tag = PostTag.new(valid_attributes)
    assert post_tag.valid?
  end

  test "is invalid without post" do
    post_tag = PostTag.new(valid_attributes.merge(post: nil))
    assert_not post_tag.valid?
  end

  test "is invalid without tag" do
    post_tag = PostTag.new(valid_attributes.merge(tag: nil))
    assert_not post_tag.valid?
  end

  test "is invalid with duplicate post and tag combination" do
    PostTag.create!(valid_attributes)
    post_tag = PostTag.new(valid_attributes)
    assert_not post_tag.valid?
  end

  test "belongs to post" do
    assert_respond_to PostTag.new, :post
  end

  test "belongs to tag" do
    assert_respond_to PostTag.new, :tag
  end

  private

  def valid_attributes
    { post: posts(:published_post), tag: tags(:fiel) }
  end
end
