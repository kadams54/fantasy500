require 'test_helper'

class FetchIndy500DriversJobTest < ActiveJob::TestCase
  def setup
    ENV["SCORING_EVENT_NAME"] = "106th Running of the Indianapolis 500"
  end

  test "that drivers have been fetched" do
    grid_json = File.read("./test/fixtures/livegrid-qualifications.json")
    drivers_json = File.read("./test/fixtures/driversfeed.json")
    stub_request(:get, ENV["GRID_API"]).to_return(body: grid_json)
    stub_request(:get, ENV["DRIVERS_API"]).to_return(body: drivers_json)
    assert_difference "Driver.current.count", 33 do
      FetchIndy500DriversJob.perform_now()
    end
  end
end
