namespace :fantasy500 do
  desc "Fetches driver info from IndyCar."
  task :fetch_indycar_drivers => :environment do
    puts "Fetching IndyCar drivers..."
    FetchIndycarDriversJob.perform_now()
    puts "Done."
  end
end
