class FetchScoringJob < ApplicationJob
  queue_as :default

  def perform(*args)
    if ENV["SCORING_UPDATES"] == "disabled"
      Rails.logger.info("Skipping scoring; disabled")
      return
    end

    Faraday.default_adapter = :net_http
    response = Faraday.get ENV["SCORING_API"]
    body = response.body.strip().sub(/jsonCallback\(/, "").chomp(");")
    scoring = JSON.parse(body)

    event_name = scoring.dig("timing_results", "heartbeat", "eventName")
    if event_name != ENV["SCORING_EVENT_NAME"]
      Rails.logger.info("Skipping scoring; wrong event: #{event_name}")
      return
    end

    lap = scoring.dig("timing_results", "heartbeat", "lapNumber").to_i
    if !lap || lap <= 0
      Rails.logger.info("Skipping scoring; invalid lap: #{lap}")
      return
    end

    Rails.logger.info("Adding scoring info for lap #{lap}")
    grid = Grid.current.find_or_create_by!(lap: lap)
    (scoring.dig("timing_results", "Item") || []).each do |result|
      driver = Driver.current.find_by(number: result["no"])
      grid.positions.find_or_create_by!(place: result["overallRank"], driver: driver)
    end
  end
end
