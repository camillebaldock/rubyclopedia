namespace :railscasts do

  desc "Fetch today's EDNA XML file and update the episodes in the database"
  task :fetch => :environment do
    RailsCastsImportService.new.processJsonFile
  end
end