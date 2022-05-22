namespace :fantasy500 do
  desc "Records a new lap with a random position assigned to each driver"
  task :record_lap, [:lap] => :environment do |t, args|
    args.with_defaults(:lap => 0)
    lap = args.lap.to_i

    puts "🟢 Recording lap #{lap}..."
    grid = Grid.current.find_or_create_by(lap: lap)
    positions = (1..33).to_a.shuffle
    puts "  🏎  Shuffling drivers..."
    Driver.current.each.with_index do |driver, index|
      puts "    ├ Moving #{driver.name} to position #{positions[index]}"
      Position.find_or_create_by!(
        place: positions[index],
        driver: driver,
        grid: grid,
      )
    end
    puts "🔴 Done."
  end
end
