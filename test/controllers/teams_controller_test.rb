require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, :active)
    @other_user = create(:user, :active)
    @admin = create(:user, :admin, :active)
    @team = create(:team, user: @user)
  end

  test "should get index for admins" do
    log_in_as @admin, password: @admin.password
    get teams_url
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get teams_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should forbid index for non-admin user" do
    log_in_as @user, password: @user.password
    get teams_url
    assert_response :forbidden
  end

  test "should get show when logged in" do
    log_in_as @user, password: @user.password
    get team_url(@team)
    assert_response :success
  end

  test "should redirect show when not logged in" do
    get team_url(@team)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as @user, password: @user.password
    get new_team_url
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_team_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should create team when logged in" do
    log_in_as @user, password: @user.password
    assert_difference('Team.count') do
      post teams_url params: {team: {name: Faker::Team.name}}
    end
    assert_redirected_to welcome_dashboard_path
  end

  test "should forbid create team when not logged in" do
    post teams_url params: {team: {name: Faker::Team.name}}
    assert_redirected_to login_url
  end

  test "should allow team owner to edit" do
    log_in_as @user, password: @user.password
    get edit_team_url(@team)
    assert_response :success
  end

  test "should forbid edit when not team owner" do
    log_in_as @other_user, password: @other_user.password
    get edit_team_url(@team)
    assert_response :forbidden
  end

  test "should allow team owner to update" do
    log_in_as @user, password: @user.password
    patch team_url(@team), params: {team: {name: Faker::Team.name}}
    assert_redirected_to welcome_dashboard_path
  end

  test "should forbid update when not team owner" do
    log_in_as @other_user, password: @other_user.password
    patch team_url(@team), params: {team: {name: Faker::Team.name}}
    assert_response :forbidden
  end

  test "should allow team owner to delete" do
    log_in_as @user, password: @user.password
    assert_difference('Team.count', -1) do
      delete team_url(@team)
    end
    assert_redirected_to welcome_dashboard_path
  end

  test "should forbid delete when not team owner" do
    log_in_as @other_user, password: @other_user.password
    delete team_url(@team)
    assert_response :forbidden
  end
end
