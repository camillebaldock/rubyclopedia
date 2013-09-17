namespace :rubytapas do
  desc "Fetch rubytapas episodes"
  task :fetch => :environment do
    RubyTapasImportService.new.parseWebsite
  end
end