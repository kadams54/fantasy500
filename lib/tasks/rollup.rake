namespace :fantasy500 do
  desc "Rolls up data from previous years."
  task :rollup => :environment do
    puts "🟢 Rolling up data…"
    puts "⟶\tPurging historical positions aside from start/finish…"
    Grid.past.where.not(lap: 0).and(Grid.past.where.not(lap: 200)).destroy_all
    puts "🔴 Done."
  end
end
