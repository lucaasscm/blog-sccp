# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    posts.each { |post| assert post.valid? }
  end

  test "is valid with all required attributes" do
    post = Post.new(valid_attributes)
    assert post.valid?
  end

  test "is invalid without title" do
    post = posts(:published_post)
    post.title = nil
    assert_not post.valid?
    assert_includes post.errors[:title], "can't be blank"
  end

  test "is invalid without content" do
    post = posts(:published_post)
    post.content = nil
    assert_not post.valid?
    assert_includes post.errors[:content], "can't be blank"
  end

  test "is invalid without status" do
    post = posts(:published_post)
    post.status = nil
    assert_not post.valid?
    assert_includes post.errors[:status], "can't be blank"
  end

  test "is invalid without user" do
    post = posts(:published_post)
    post.user = nil
    assert_not post.valid?
  end

  test "is invalid without category" do
    post = posts(:published_post)
    post.category = nil
    assert_not post.valid?
  end

  test "default status is draft" do
    post = Post.new(valid_attributes.except(:status))
    assert_equal "draft", post.status
  end

  test "is invalid with invalid status" do
    post = posts(:published_post)
    post.status = "invalid"
    assert_not post.valid?
  end

  test "published scope returns only published posts" do
    assert Post.published.all?(&:published?)
  end

  test "published scope returns posts ordered by id desc" do
    ids = Post.published.pluck(:id)
    assert_equal ids.sort.reverse, ids
  end

  test "belongs to user" do
    assert_respond_to Post.new, :user
  end

  test "belongs to category" do
    assert_respond_to Post.new, :category
  end

  test "has one attached cover image" do
    assert_respond_to Post.new, :cover_image
  end

  test "has many post_tags" do
    assert_respond_to posts(:published_post), :post_tags
  end

  test "has many tags through post_tags" do
    assert_respond_to posts(:published_post), :tags
  end

  private

  def valid_attributes
    {
      title: "Corinthians vence mais uma",
      content: "Grande vitória do Timão.",
      status: "draft",
      user: users(:one),
      category: categories(:jogos)
    }
  end
end
