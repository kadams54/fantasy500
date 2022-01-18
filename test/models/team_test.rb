require "test_helper"

class TeamTest < ActiveSupport::TestCase
  def setup
    user = create(:user, :active)
    @team = create(:team, user: user)
  end

  test "#score" do
    grid = create(:grid, :start)

    driver_one = create(:driver, teams: [@team]) 
    create(:position, place: 3, driver: driver_one, grid: grid)

    driver_two = create(:driver, teams: [@team]) 
    create(:position, place: 8, driver: driver_two, grid: grid)

    assert_equal(11, @team.score)
  end
end
