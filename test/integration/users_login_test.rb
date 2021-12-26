require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user, :active, password_digest: User.digest('password'))
  end

  test "login with invalid information" do
    get login_path
    assert_template "sessions/new"
    log_in_as User.new(email: "noman@example.com"), password: "foobar"
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    assert_template "sessions/new"
    log_in_as @user
    assert_redirected_to @user
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", root_path
  end

  test "login followed by logout" do
    get login_path
    log_in_as @user
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
  end

  test "logging out in multiple windows" do
    get login_path
    log_in_as @user
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
  end

  test "login with remembering" do
    log_in_as @user
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end
end
