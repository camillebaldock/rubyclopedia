namespace :rubytapas do
  desc "Fetch rubytapas articles"
  task :fetch => :environment do
    RubyTapasImportService.new.parse_website
  end
end