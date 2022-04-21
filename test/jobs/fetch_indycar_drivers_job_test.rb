require 'test_helper'

class FetchIndycarDriversJobTest < ActiveJob::TestCase
  test "that drivers have been fetched" do
    list_html = File.read("./test/fixtures/indycar-drivers.html")
    uri = URI.parse(ENV["INDYCAR_URL"])
    base_url = "#{uri.scheme}://#{uri.host}"
    driver_1_html = File.read("./test/fixtures/indycar-drivers-1.html")
    driver_2_html = File.read("./test/fixtures/indycar-drivers-2.html")
    driver_3_html = File.read("./test/fixtures/indycar-drivers-3.html")
    stub_request(:get, ENV["INDYCAR_URL"]).to_return(body: list_html)
    stub_request(:get, base_url + '/Series/IndyCar-Series/Josef-Newgarden').to_return(body: driver_1_html)
    stub_request(:get, base_url + '/Series/IndyCar-Series/Scott-McLaughlin').to_return(body: driver_2_html)
    stub_request(:get, base_url + '/Series/IndyCar-Series/Alex-Palou').to_return(body: driver_3_html)
    assert_difference "Driver.current.count", 3 do
      FetchIndycarDriversJob.perform_now()
    end
  end
end
