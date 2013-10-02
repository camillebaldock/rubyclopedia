namespace :pluralsight do

  desc "Fetch pluralsight videos"
  task :fetch => :environment do
    PluralsightImportService.new.parse_website
  end
end