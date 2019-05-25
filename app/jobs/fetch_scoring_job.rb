class FetchScoringJob < ApplicationJob
  queue_as :default

  def perform(*args)
    response = Faraday.get "https://racecontrol.indycar.com/xml/timingscoring.json"
    scoring = JSON.parse(response.body)
    lap = scoring.dig("timing_results", "heartbeat", "lapNumber").to_i
    if lap && lap > 0
      Rails.logger.info("Adding scoring info for lap #{lap}")
      grid = Grid.find_or_create_by(lap: lap)
      scoring["timing_results"]["Item"].each do |result|
        driver = Driver.find_by(number: result["no"])
        grid.positions.build(place: result["overallRank"], driver: driver)
      end
    else
      Rails.logger.info("Skipping scoring; no lap info found")
    end
  end
end
