# frozen_string_literal: true

require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "new is accessible without authentication" do
    get new_registration_path
    assert_response :success
    assert_not response.redirect?
  end

  test "create with valid params creates user and redirects" do
    assert_difference "User.count", 1 do
      post registration_path, params: { user: valid_params }
    end
    assert_redirected_to root_path
  end

  test "create signs in the user after registration" do
    post registration_path, params: { user: valid_params }
    assert cookies[:session_id]
  end

  test "create sets role to nil by default" do
    post registration_path, params: { user: valid_params }
    assert_nil User.order(:id).last.role
  end

  test "create with invalid params renders new" do
    post registration_path, params: { user: valid_params.merge(name: "") }
    assert_response :unprocessable_entity
  end

  test "create with duplicate email renders new" do
    post registration_path, params: { user: valid_params.merge(email_address: users(:lucas).email_address) }
    assert_response :unprocessable_entity
  end

  test "create with mismatched passwords renders new" do
    post registration_path, params: { user: valid_params.merge(password_confirmation: "wrong") }
    assert_response :unprocessable_entity
  end

  private

  def valid_params
    {
      name: "Novo Fiel",
      email_address: "novo@fiel.com",
      password: "password",
      password_confirmation: "password"
    }
  end
end
