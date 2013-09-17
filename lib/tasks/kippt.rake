namespace :kippt do
  desc "Fetch rubytapas episodes"
  task :fetch => :environment do
    KipptImportService.new.parseFeed
  end
end