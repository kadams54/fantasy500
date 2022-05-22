namespace :fantasy500 do
  desc "Simulates the 2021 Indy 500 race"
  task :simulate_race, [:lap, :restart] => :environment do |t, args|
    args.with_defaults(:lap => 0)
    args.with_defaults(:restart => false)
    lap = args.lap.to_i
    restart = args.restart
    puts "🟢 Creating lap #{lap}..."

    if restart
      puts "  🗑  Resetting all data..."
      Position.delete_all
      Grid.delete_all
      Team.all.each do |team|
        team.leagues.clear
        team.drivers.clear
      end
      League.delete_all
      Team.delete_all
      Driver.delete_all
      User.delete_all

      puts "  👤 Loading users..."
      execute_sql "playwright/fixtures/users.sql"

      puts "  🏎  Loading drivers..."
      execute_sql "playwright/fixtures/drivers.sql"

      puts "  👥 Loading teams..."
      execute_sql "playwright/fixtures/teams.sql"
      execute_sql "playwright/fixtures/drivers_teams.sql"

      puts "  🏅 Loading leagues..."
      execute_sql "playwright/fixtures/leagues.sql"
      execute_sql "playwright/fixtures/leagues_teams.sql"
    end

    puts "  🏁 Loading the grid..."
    grids = JSON.parse(File.read('playwright/fixtures/grids.json'))
    grid = nil
    while grid.nil?
      puts "    ├ Checking lap #{lap} for a grid..."
      grid = grids.find { |g| g['lap'] == lap }
      lap += 1
    end
    puts "    └ Grid found."
    if Grid.exists?(:lap => grid['lap'])
      puts "🔴 Done: grid already exists for lap #{grid['lap']}."
      exit 1
    end
    Grid.create!(grid)

    puts "  🏆 Loading the positions..."
    positions = JSON.parse(File.read('playwright/fixtures/positions.json'))
    Position.insert_all!(positions.select { |position| position['grid_id'] == grid['id'] })

    puts "🔴 Done."
  end
end

def execute_sql(file)
  connection = ActiveRecord::Base.connection

  sql = File.read(file)
  statements = sql.split(/;$/)
  statements.pop
  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement)
    end
  end
end
