# frozen_string_literal: true

require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    tags.each { |tag| assert tag.valid? }
  end

  test "is invalid without title" do
    tag = tags(:libertadores)
    tag.title = nil
    assert_not tag.valid?
    assert_includes tag.errors[:title], "can't be blank"
  end

  test "is invalid with duplicate title" do
    tag = Tag.new(valid_attributes.merge(title: tags(:libertadores).title))
    assert_not tag.valid?
    assert_includes tag.errors[:title], "has already been taken"
  end

  test "is valid with all required attributes" do
    tag = Tag.new(valid_attributes)
    assert tag.valid?
  end

  test "has many post_tags" do
    assert_respond_to tags(:libertadores), :post_tags
  end

  test "has many posts through post_tags" do
    assert_respond_to tags(:libertadores), :posts
  end

  private

  def valid_attributes
    { title: "Paulistão" }
  end
end
