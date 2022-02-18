require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user, :active, password_digest: User.digest('password'))
  end

  test "should get index" do
    get welcome_index_url
    assert_response :success
  end

  test "should redirect to dashboard if logged in" do
    log_in_as @user
    get welcome_index_url
    assert_response :redirect
  end
end
