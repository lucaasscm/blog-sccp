# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'downcases and strips email_address' do
    user = User.new(email_address: ' DOWNCASED@EXAMPLE.COM ')
    assert_equal('downcased@example.com', user.email_address)
  end

  test 'is valid with all required attributes' do
    user = User.new(valid_attributes)
    assert user.valid?
  end

  test 'is invalid without name' do
    user = User.new(valid_attributes.merge(name: nil))
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test 'is invalid without email_address' do
    user = User.new(valid_attributes.merge(email_address: nil))
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test 'is invalid with duplicate email_address' do
    User.create!(valid_attributes)
    user = User.new(valid_attributes.merge(name: 'Outro'))
    assert_not user.valid?
    assert_includes user.errors[:email_address], 'has already been taken'
  end

  test 'is invalid with malformed email_address' do
    user = User.new(valid_attributes.merge(email_address: 'not-an-email'))
    assert_not user.valid?
    assert_includes user.errors[:email_address], 'is invalid'
  end

  test 'is invalid without password' do
    user = User.new(valid_attributes.merge(password: nil, password_confirmation: nil))
    assert_not user.valid?
  end

  test 'default role is nil' do
    user = User.new(valid_attributes)
    assert_nil user.role
  end

  test 'is invalid with invalid role' do
    user = User.new(valid_attributes.merge(role: 'superheroi'))
    assert_not user.valid?
  end

  test 'is valid without role' do
    user = User.new(valid_attributes.merge(role: nil))
    assert user.valid?
  end

  test 'admin? returns true when role is admin' do
    user = User.new(valid_attributes.merge(role: 'admin'))
    assert user.admin?
  end

  test 'author? returns true when role is author' do
    user = User.new(valid_attributes.merge(role: 'author'))
    assert user.author?
  end

  private

  def valid_attributes
    {
      name: 'Lucas',
      email_address: 'lucas@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    }
  end
end
