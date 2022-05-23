def fetch(url)
  Faraday.default_adapter = :net_http
  response = Faraday.get url
  body = response.body.strip().sub(/\w+Callback\(/, "").chomp(");")
  JSON.parse(body)
end

MAKE_MODEL = {
  'H' => 'Honda',
  'C' => 'Chevrolet',
}

class FetchIndy500DriversJob < ApplicationJob
  queue_as :default

  def perform(*args)
    grid = fetch ENV["GRID_API"]
    drivers = fetch ENV["DRIVERS_API"]

    event_name = grid.dig("timing_results", "heartbeat", "eventName")
    if event_name != ENV["SCORING_EVENT_NAME"]
      raise "Aborting driver fetch; wrong event: '#{event_name}', should be: '#{ENV["SCORING_EVENT_NAME"]}'"
    end

    session_type = grid.dig("timing_results", "heartbeat", "SessionType")
    if session_type != "Q"
      raise "Aborting driver fetch; scoring data is not for qualifying sesssion: #{session_type}"
    end

    items = grid.dig("timing_results", "Item") || []
    if items.length != 33
      raise "Scoring contained an unexpected number of positions: #{items.length}"
    end

    driver_images = {}
    car_images = {}
    (drivers.dig("drivers", "driver") || []).each do |driver|
      driver_images[driver["name"]] = driver["headshot"]
      car_images[driver["number"]] = driver["carillustration"]
    end

    grid = Grid.current.find_or_create_by!(lap: 0)
    items.each do |item|
      name = "#{item["firstName"]} #{item["lastName"]}"
      place = item["overallRank"]
      Rails.logger.info("#{(place).to_s.rjust(2, ' ')}: #{name}")
      driver = Driver.current.create_with(
        number: item["no"],
        make_model: MAKE_MODEL[item["equipment"].split('/').second],
        driver_image: driver_images[name],
        car_image: car_images[item["no"]],
        qualifying_speed: item.dig("AverageSpeed"),
        team: item["team"],
      ).find_or_create_by!(
        name: name,
      )
      Rails.logger.info("🤖 Driver: [#{driver.id}] #{driver.name}")
      grid.positions
        .create_with(driver: driver)
        .find_or_create_by!(place: place)
    end
  end
end
