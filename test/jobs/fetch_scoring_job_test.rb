require 'test_helper'

class FetchScoringJobTest < ActiveJob::TestCase
  test "that scores have been fetched" do
    json = File.read("./test/fixtures/timingscoring.json")
    stub_request(:get, "https://racecontrol.indycar.com/xml/timingscoring.json").to_return(body: json)
    assert_difference "Grid.count", 1 do
      FetchScoringJob.perform_now()
    end
  end
end
