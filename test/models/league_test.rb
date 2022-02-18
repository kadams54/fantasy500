require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  def setup
    commish = create(:user, :active)
    @league = create(:league, commish: commish)
  end

  test "should be valid" do
    assert @league.valid?
  end

  test "name should be present" do
    @league.name = "      "
    assert_not @league.valid?
  end

  test "#rank with single team" do
    user_one = create(:user, :active)

    grid = create(:grid, :start)

    driver_one = create(:driver) 
    create(:position, place: 3, driver: driver_one, grid: grid)
    driver_two = create(:driver) 
    create(:position, place: 8, driver: driver_two, grid: grid)

    team_one = create(:team, leagues: [@league], user: user_one, drivers: [driver_one, driver_two])
    assert_equal(1, @league.rank(team_one))
  end

  test "#rank with multiple teams" do
    user_one = create(:user, :active)
    user_two = create(:user, :active)

    grid = create(:grid, :start)

    driver_one = create(:driver) 
    create(:position, place: 3, driver: driver_one, grid: grid)
    driver_two = create(:driver) 
    create(:position, place: 8, driver: driver_two, grid: grid)
    driver_three = create(:driver) 
    create(:position, place: 15, driver: driver_three, grid: grid)

    team_one = create(:team, leagues: [@league], user: user_one, drivers: [driver_two, driver_three])
    team_two = create(:team, leagues: [@league], user: user_two, drivers: [driver_one, driver_two])

    assert_equal(1, @league.rank(team_two))
    assert_equal(2, @league.rank(team_one))
  end

  test "does not authenticate an invalid token" do
    assert_not(@league.authenticated?(:membership, 'invalid'))
  end

  test "authenticates a valid token" do
    assert(@league.authenticated?(:membership, @league.membership_token))
  end
end
