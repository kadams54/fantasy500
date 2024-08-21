require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    skip "User registrations turned off"
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference "User.count" do
      post signup_path, params: {user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}}
    end
    assert_template "users/new"
    assert_select ".toast-error"
    assert_select ".field_with_errors"
  end

  test "valid signup information with account activation" do
    skip "User registrations turned off"
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference "User.count", 1 do
      post users_path, params: {user: {name: "Ned Stark", email: "ned@example.com", password: "LannistersAreTheWorst", password_confirmation: "LannistersAreTheWorst"}}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid activation token, wrong email
    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert is_logged_in?
  end
end
