require 'test_helper'

class FetchIndy500DriversJobTest < ActiveJob::TestCase
  test "that drivers have been fetched" do
    html = File.read("./test/fixtures/indy500-grid.html")
    stub_request(:get, ENV["GRID_URL"]).to_return(body: html)
    assert_difference "Driver.current.count", 33 do
      FetchIndy500DriversJob.perform_now()
    end
  end
end
