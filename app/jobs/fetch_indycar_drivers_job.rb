class FetchIndycarDriversJob < ApplicationJob
  queue_as :default

  def perform(*args)
    uri = URI.parse(ENV["INDYCAR_URL"])

    doc = Nokogiri::HTML(Net::HTTP.get(uri))
    if !doc
      raise "Unable to fetch HTML"
      return
    end

    base_url = "#{uri.scheme}://#{uri.host}"
    year = Time.current.year.to_i

    drivers = doc.css(".driver-listing__driver-profile")
    Rails.logger.info("Found #{drivers.length} drivers.")

    links = drivers
      .map { |driver| driver.css("a").attribute('href').value }
      .map { |path| base_url + path }
    data = []
    links.each_with_index do |link, idx|
      profile = Nokogiri::HTML(Net::HTTP.get(URI.parse(link)))
      if !profile
        raise "Unable to fetch driver details HTML"
        next
      end

      car_image = profile.css(".driver-car-image").attribute("src").value
      driver_image = profile.css(".driver-detail-img").attribute("src").value
      make_model = profile.css(".driver-profile__profile-image").attribute("alt").value
      name = profile.css(".driver-detail-meta__driver-name").text.squish
      endplate = profile.css(".header-stats__graphics > img[src*='Endplates']").attribute("alt")
      team = profile.css(".driver-detail-meta__team-name").text.squish

      Rails.logger.info("#{(idx + 1).to_s.rjust(2, " ")}: #{name}")
      data.push({
        car_image: base_url + car_image,
        driver_image: base_url + driver_image,
        make_model: make_model,
        name: name,
        number: endplate&.value&.to_i,
        team: team,
        year: year
      })
    end

    Driver.upsert_all(
      data,
      unique_by: %i[ name year ],
      update_only: %i[ car_image driver_image make_model name team ],
    )
  end
end
