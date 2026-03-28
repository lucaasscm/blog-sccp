# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    categories.each { |category| assert category.valid? }
  end

  test "is invalid without title" do
    category = categories(:mercado_da_bola)
    category.title = nil
    assert_not category.valid?
    assert_includes category.errors[:title], "can't be blank"
  end

  test "is invalid with duplicate title" do
    category = Category.new(valid_attributes.merge(title: categories(:mercado_da_bola).title))
    assert_not category.valid?
    assert_includes category.errors[:title], "has already been taken"
  end

  test "is valid with all required attributes" do
    category = Category.new(valid_attributes)
    assert category.valid?
  end

  private

  def valid_attributes
    { title: "Copa do Brasil" }
  end
end
