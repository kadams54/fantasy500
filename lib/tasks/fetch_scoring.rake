namespace :fantasy500 do
  desc "Fetches scoring updates from IndyCar."
  task :fetch_scoring => :environment do
    puts "Fetching scoring..."
    FetchScoringJob.perform_now() 
    puts "Done."
  end
end
