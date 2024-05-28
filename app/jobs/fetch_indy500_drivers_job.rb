def fetch(url)
  Faraday.default_adapter = :net_http
  response = Faraday.get url
  body = response.body.strip.sub(/\w+Callback\(/, "").chomp(");")
  JSON.parse(body)
end

class FetchIndy500DriversJob < ApplicationJob
  queue_as :default

  def perform(*args)
    grid_data = fetch ENV["GRID_API"]
    drivers = fetch ENV["DRIVERS_API"]

    if grid_data.length != 33
      raise "Scoring contained an unexpected number of positions: #{grid_data.length}"
    end

    driver_images = {}
    car_images = {}
    teams = {}
    (drivers.dig("drivers", "driver") || []).each do |driver|
      driver_images[driver["name"]] = driver["headshot"]
      car_images[driver["number"]] = driver["carillustration"]
      teams[driver["name"]] = driver["team"]
    end

    grid = Grid.current.find_or_create_by!(lap: 0)
    grid_data.each_with_index do |g, index|
      name = g["Driver"]
      place = index + 1
      Rails.logger.info("#{place.to_s.rjust(2, " ")}: #{name}")
      driver = Driver.current.create_with(
        number: g["CarNumber"],
        make_model: Driver::MAKE_MODEL[g["Equipment"].split("/").second],
        driver_image: driver_images[name],
        car_image: car_images[g["CarNumber"]],
        qualifying_speed: g["QualifyingSpeed"],
        team: teams[name]
      ).find_or_create_by!(
        name: name
      )
      grid.positions
        .create_with(driver: driver)
        .find_or_create_by!(place: place)
    end
  end
end
