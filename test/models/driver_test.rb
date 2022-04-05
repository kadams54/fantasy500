require "test_helper"

class DriverTest < ActiveSupport::TestCase
  def setup
    @driver = create(:driver)
  end

  test '#current' do
    historical_driver = create(:driver, :historical)
    assert_includes Driver.current, @driver
    assert_not_includes Driver.current, historical_driver
  end

  test '#starting_position' do
    starting_grid = create(:grid, :start)
    finishing_grid = create(:grid, :finish)
    
    create(:position, place: 4, driver: @driver, grid: starting_grid)
    assert_equal(4, @driver.starting_position)
    create(:position, place: 1, driver: @driver, grid: finishing_grid)
    assert_equal(4, @driver.starting_position)
  end

  test '#current_position' do
    starting_grid = create(:grid, :start)
    midway_grid = create(:grid, lap: 100)
    finishing_grid = create(:grid, :finish)

    create(:position, place: 1, driver: @driver, grid: starting_grid)
    assert_equal(1, @driver.current_position)
    create(:position, place: 2, driver: @driver, grid: midway_grid)
    assert_equal(2, @driver.current_position)
    create(:position, place: 3, driver: @driver, grid: finishing_grid)
    assert_equal(3, @driver.current_position)
  end
end
