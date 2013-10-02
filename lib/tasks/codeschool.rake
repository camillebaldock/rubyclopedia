namespace :codeschool do

  desc "Fetch codecademy courses"
  task :fetch => :environment do
    CodeschoolImportService.new.process_screencasts
    CodeschoolImportService.new.process_courses
  end
end