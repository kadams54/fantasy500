namespace :fantasy500 do
  desc "Fetches driver info from IMS."
  task :fetch_indy500_drivers => :environment do
    puts "Fetching Indy 500 drivers..."

    doc = Nokogiri::HTML(Net::HTTP.get(URI.parse(ENV["GRID_URL"])))
    if !doc
      raise "Unable to fetch HTML"
      return
    end

    positions = doc.css("div[style*='liveGridPositions']")
    if positions.length != 33
      raise "HTML contained an unexpected number of positions"
      return
    end

    grid = Grid.current.find_or_create_by(lap: 0) 
    positions.each_with_index do |position, idx|
      # These selectors are gnarly because the IMS starting grid page currently
      # has very little semantic markup. So I'm quarantining them all here.
      # BEGIN: gnarly selectors
      car_image = position.css("img[src*='Liveries']").attribute('src').value
      driver_image = position.css("img[src*='Headshot']").attribute('src').value
      qualifying_speed = position.xpath(".//div[@style='text-align: right;']/div[@class='row']/div[last()]/text()").text.to_f 
      name = position.xpath(".//div[@style='text-align: right;']/p").text
      endplate = position.xpath(".//img[contains(@src, 'Endplates')]/@src").text
      logo = position.xpath(".//img[contains(@src, '_logo')]/@src").text
      # END: gnarly selectors
      puts "#{(idx + 1).to_s.rjust(2, ' ')}: #{name}"
      driver = Driver.create!(
        name: name,
        number: endplate.match(/Endplates\/(\d+)-/)[1],  # could fail if match is nil
        make_model: logo.match(/img_(\w+)_logo/)[1].capitalize,  # could fail if match is nil
        driver_image: driver_image,
        car_image: car_image,
        qualifying_speed: qualifying_speed,
      )
      grid.positions.create!(place: idx + 1, driver: driver)
    end

    puts "Done."
  end
end
