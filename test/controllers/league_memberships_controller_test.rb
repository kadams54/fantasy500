require 'test_helper'

class LeagueMembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @league = create(:league)
  end

  test "should get edit for invited users" do
    invited_user = create(:user, :active)
    create(:team, user: invited_user)
    log_in_as invited_user, password: invited_user.password
    get edit_league_membership_url id: @league.membership_token, params: {league_id: @league.id}
    assert_redirected_to welcome_dashboard_url
    assert_equal "Welcome to the #{@league.name} league!", flash[:success]
  end

  test "should redirect edit for invited users" do
    uninvited_user = create(:user, :active)
    log_in_as uninvited_user, password: uninvited_user.password
    get edit_league_membership_url id: "invalid", params: {league_id: @league.id}
    assert_redirected_to welcome_dashboard_url
    assert_equal "Invalid league membership link.", flash[:danger]
  end
end
