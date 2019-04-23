require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference "User.count" do
      post signup_path, params: {user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}}
    end
    assert_template "users/new"
    assert_select ".toast-error"
    assert_select ".field_with_errors"
  end

  test "valid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference "User.count", 1 do
      post signup_path, params: {user: {name: "Ned Stark", email: "ned@example.com", password: "LannistersAreTheWorst", password_confirmation: "LannistersAreTheWorst"}}
    end
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
    assert flash[:success]
  end
end
