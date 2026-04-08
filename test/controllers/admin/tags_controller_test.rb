# frozen_string_literal: true

require "test_helper"

module Admin
  class TagsControllerTest < ActionDispatch::IntegrationTest
    setup { sign_in_as(users(:lucas)) }

    test "index returns success" do
      get admin_tags_path
      assert_response :success
    end

    test "index redirects to login when not authenticated" do
      sign_out
      get admin_tags_path
      assert_redirected_to new_session_path
    end

    test "new returns success" do
      get new_admin_tag_path
      assert_response :success
    end

    test "create saves tag and redirects" do
      assert_difference "Tag.count", 1 do
        post admin_tags_path, params: { tag: { title: "Nova Tag" } }
      end
      assert_redirected_to admin_tags_path
    end

    test "create with invalid params renders new" do
      post admin_tags_path, params: { tag: { title: "" } }
      assert_response :unprocessable_entity
    end

    test "create with duplicate title renders new" do
      post admin_tags_path, params: { tag: { title: tags(:fiel).title } }
      assert_response :unprocessable_entity
    end

    test "edit returns success" do
      get edit_admin_tag_path(tags(:fiel))
      assert_response :success
    end

    test "update saves changes and redirects" do
      patch admin_tag_path(tags(:fiel)), params: { tag: { title: "Fiel Torcida" } }
      assert_redirected_to admin_tags_path
      assert_equal "Fiel Torcida", tags(:fiel).reload.title
    end

    test "update with invalid params renders edit" do
      patch admin_tag_path(tags(:fiel)), params: { tag: { title: "" } }
      assert_response :unprocessable_entity
    end

    test "destroy deletes tag and redirects" do
      assert_difference "Tag.count", -1 do
        delete admin_tag_path(tags(:libertadores))
      end
      assert_redirected_to admin_tags_path
    end
  end
end
