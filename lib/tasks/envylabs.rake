namespace :envylabs do

  desc "Fetch envylabs articles"
  task :fetch => :environment do
    EnvylabsImportService.new.process
  end
end