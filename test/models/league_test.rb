require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  def setup
    @commish = users(:frodo)
    @league = @commish.leagues.new(name: "Furry Feet Brigade")
  end

  test "should be valid" do
    assert @league.valid?
  end

  test "name should be present" do
    @league.name = "      "
    assert_not @league.valid?
  end
end
