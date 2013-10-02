namespace :codecademy do

  desc "Fetch codecademy courses"
  task :fetch => :environment do
    CodecademyImportService.new.process_json_file
  end
end