require 'test_helper'

class LeaguesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commish = create(:user, :active)
    create(:team, user: @commish)
    @other_user = create(:user, :active)
    create(:team, user: @other_user)
    @league = create(:league, commish: @commish, teams: [@commish.teams.first])
  end

  test "should hide index from guests" do
    get leagues_url
    assert_redirected_to login_url
  end

  test "should get index for logged in user" do
    log_in_as @commish, password: @commish.password
    get leagues_url
    assert_response :success
  end

  test "should get new for logged in user" do
    log_in_as @commish, password: @commish.password
    get new_league_url
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_league_url
    assert_redirected_to login_url
  end

  test "should create league for logged in user" do
    log_in_as @commish, password: @commish.password
    assert_difference('League.count') do
      post leagues_url, params: {league: {name: Faker::Team.name}}
    end
    assert_redirected_to welcome_dashboard_path
  end

  test "should redirect create when not logged in" do
    post leagues_url, params: {league: {name: Faker::Team.name}}
    assert_redirected_to login_url
  end

  test "should show league" do
    get league_url(@league)
    assert_response :success
  end

  test "should get edit for commish" do
    log_in_as @commish, password: @commish.password
    get edit_league_url(@league)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_league_url(@league)
    assert_redirected_to login_url
  end

  test "should forbid edit when not commish" do
    log_in_as @other_user, password: @other_user.password
    get edit_league_url(@league)
    assert_response :forbidden
  end

  test "should update league for commish" do
    log_in_as @commish, password: @commish.password
    patch league_url(@league), params: {league: {name: Faker::Team.name}}
    assert_redirected_to welcome_dashboard_path
  end

  test "should redirect update when not logged in" do
    patch league_url(@league), params: {league: {name: Faker::Team.name}}
    assert_redirected_to login_url
  end

  test "should forbid update when not commish" do
    log_in_as @other_user, password: @other_user.password
    patch league_url(@league), params: {league: {name: Faker::Team.name}}
    assert_response :forbidden
  end

  test "should destroy league for commish" do
    log_in_as @commish, password: @commish.password
    assert_difference('League.count', -1) do
      delete league_url(@league)
    end
    assert_redirected_to welcome_dashboard_url
  end

  test "should redirect destroy when not logged in" do
    delete league_url(@league)
    assert_redirected_to login_url
  end

  test "should forbid destroy when not commish" do
    log_in_as @other_user, password: @other_user.password
    delete league_url(@league)
    assert_response :forbidden
  end

  test "should allow joining a league" do
    log_in_as @other_user, password: @other_user.password
    post join_league_url(@league)
    assert_redirected_to welcome_dashboard_url
  end
end
