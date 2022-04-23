starting_grid = Grid.first

Driver.all.order(qualifying_speed: :desc).each.with_index do |driver, index|
  Position.find_or_create_by!(
    place: index + 1,
    driver: driver,
    grid: starting_grid,
  )
end
