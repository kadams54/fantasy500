require 'test_helper'

MAKE_MODEL = {
  'H' => 'Honda',
  'C' => 'Chevrolet',
}

def load_drivers(json)
  JSON.parse(json).dig("timing_results", "Item").each do |item|
    driver = Driver.current.create_with(
      number: item["no"],
      make_model: MAKE_MODEL[item["equipment"].split('/').second],
    ).find_or_create_by!(
      name: "#{item["firstName"]} #{item["lastName"]}",
    )
  end
end

class FetchScoringJobTest < ActiveJob::TestCase
  def setup
    ENV["SCORING_UPDATES"] = "enabled"
    ENV["SCORING_EVENT_NAME"] = "INDYCAR Indianapolis 500"
    @json = File.read("./test/fixtures/timingscoring.json")
    load_drivers(@json)
    stub_request(:get, ENV["SCORING_API"]).to_return(body: @json)
  end

  test "that scores have been fetched" do
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

  test "that scores are skipped when the lap has already been recorded" do
    FetchScoringJob.perform_now()
    assert_no_difference "Position.current.count" do
      FetchScoringJob.perform_now()
    end
  end
end
