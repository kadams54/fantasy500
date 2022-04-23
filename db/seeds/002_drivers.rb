Driver.destroy_all

33.times do |i|
  Driver.create!(
    name: Faker::Name.first_name + ' ' + Faker::Name.unique.last_name,
    number: Faker::Number.number(digits: 2).to_s,
    team: Faker::Team.name,
    make_model: Faker::Vehicle.make_and_model,
    driver_image: "https://d1b8ufspcmikd1.cloudfront.net/-/media/IndyCar/Drivers/IndyCar-Series/Headshot/ScottDixon.jpg?dp=03-10-2021T03:50PM",
    car_image: "https://d1b8ufspcmikd1.cloudfront.net/-/media/IndyCar/Cars/2021/IndyCar-Series/Liveries/Indy500/9-PNCGrowUp-I500.png?dp=05-17-2021T01:29PM",
    qualifying_speed: ("%0.3f" % Faker::Number.between(from: 225, to: 235).round(3)).to_f,
  )
end
