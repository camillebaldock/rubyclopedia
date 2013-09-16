namespace :railscasts do

  desc "Fetch railscasts episodes"
  task :fetch => :environment do
    RailsCastsImportService.new.processJsonFile
  end
end