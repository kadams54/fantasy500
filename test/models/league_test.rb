require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  def setup
    @commish = users(:frodo)
    @league = @commish.leagues.new(name: "Furry Feet Brigade", password: "shire", password_confirmation: "shire")
  end

  test "should be valid" do
    assert @league.valid?
  end

  test "name should be present" do
    @league.name = "      "
    assert_not @league.valid?
  end

  test "password should be present (nonblank)" do
    @league.password = @league.password_confirmation = " " * 6
    assert_not @league.valid?
  end
end
