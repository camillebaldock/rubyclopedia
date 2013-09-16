namespace :rubyrogues do

  desc "Fetch rubyrogues episodes"
  task :fetch => :environment do
    RubyRoguesImportService.new.parseWebsite
  end
end