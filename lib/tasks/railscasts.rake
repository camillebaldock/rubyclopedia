namespace :railscasts do

  desc "Fetch railscasts articles"
  task :fetch => :environment do
    RailsCastsImportService.new.process_json_file
  end
end