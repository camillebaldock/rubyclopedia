namespace :codecademy do

  desc "Fetch codecademy courses"
  task :fetch => :environment do
    CodecademyImportService.new.process_courses
  end
end