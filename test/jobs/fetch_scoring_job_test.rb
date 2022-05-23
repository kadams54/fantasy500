require 'test_helper'

class FetchScoringJobTest < ActiveJob::TestCase
  def setup
    ENV["SCORING_UPDATES"] = "enabled"
    ENV["SCORING_EVENT_NAME"] = "INDYCAR Indianapolis 500"
  end

  test "that scores have been fetched" do
    json = File.read("./test/fixtures/timingscoring.json")
    stub_request(:get, ENV["SCORING_API"]).to_return(body: json)
    assert_difference "Grid.current.count", 1 do
      FetchScoringJob.perform_now()
    end
  end

  test "that scores have been fetched from callback-wrapped JSON" do
    json = File.read("./test/fixtures/timingscoring-withcallback.json")
    stub_request(:get, ENV["SCORING_API"]).to_return(body: json)
    assert_difference "Grid.current.count", 1 do
      FetchScoringJob.perform_now()
    end
  end

  test "that scores are skipped when updates disabled" do
    ENV["SCORING_UPDATES"] = "disabled"
    assert_no_difference "Grid.current.count" do
      FetchScoringJob.perform_now()
    end
  end

  test "that scores are skipped when wrong event" do
    ENV["SCORING_EVENT_NAME"] = "wrong event"
    json = File.read("./test/fixtures/timingscoring.json")
    stub_request(:get, ENV["SCORING_API"]).to_return(body: json)
    assert_no_difference "Grid.current.count" do
      FetchScoringJob.perform_now()
    end
  end

  test "that scores are skipped when no laps" do
    json = File.read("./test/fixtures/timingscoring-nolaps.json")
    stub_request(:get, ENV["SCORING_API"]).to_return(body: json)
    assert_no_difference "Grid.current.count" do
      FetchScoringJob.perform_now()
    end
  end
end
