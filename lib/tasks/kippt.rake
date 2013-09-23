namespace :kippt do
  desc "Fetch rubytapas articles"
  task :fetch => :environment do
    KipptImportService.new.parse_feed
  end
end