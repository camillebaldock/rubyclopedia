namespace :rubyrogues do

  desc "Fetch rubyrogues articles"
  task :fetch => :environment do
    RubyRoguesImportService.new.parse_website
  end
end