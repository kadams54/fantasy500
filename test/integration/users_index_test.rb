require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user, :active, password_digest: User.digest('password'))
    @admin = create(:user, :admin, :active, password_digest: User.digest('password'))
    @inactive_user = create(:user, :inactive)
  end

  test "index including pagination and delete buttons" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select ".pagination", count: 2
    User.activated.paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: "Delete"
      end
    end
  end

  test "index hidden from non-admins" do
    log_in_as(@user)
    get users_path
    assert_response :forbidden
  end

  test "index allows admins to delete users" do
    log_in_as(@admin)
    get users_path
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
  end
end
