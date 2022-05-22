namespace :fantasy500 do
  desc "Creates a simulated race"
  task :create_race, [:lap] => :environment do |t, args|
    args.with_defaults(:lap => 0)
    lap = args.lap.to_i
    puts "🟢 Creating lap #{lap}..."

    if race_start? lap
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

def race_start?(lap)
  lap == 0
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
