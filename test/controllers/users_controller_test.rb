require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user, :active, password_digest: User.digest('password'))
    @other_user = create(:user, :active, password_digest: User.digest('password'))
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {user: {name: @user.name, email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should error edit when logged in as wrong user" do
    log_in_as @user
    get edit_user_path(@other_user)
    assert_response :forbidden
  end

  test "should error update when logged in as wrong user" do
    log_in_as @user
    patch user_path(@other_user), params: {user: {name: @user.name, email: @user.email}}
    assert_response :forbidden
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as @other_user
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {user: {admin: true}}
    assert_not @other_user.reload.admin?
  end

  test "should not allow non-admin users to delete" do
    log_in_as @other_user
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_response :forbidden
  end
end
