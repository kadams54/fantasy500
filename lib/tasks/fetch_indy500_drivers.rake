namespace :fantasy500 do
  desc "Fetches driver info from IMS."
  task :fetch_indy500_drivers => :environment do
    puts "Fetching Indy 500 drivers..."
    FetchIndy500DriversJob.perform_now()
    puts "Done."
  end
end
