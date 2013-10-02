namespace :import do

  desc "Fetch all entries"
  task :all => :environment do
    Rake::Task["codecademy:fetch"].invoke
    Rake::Task["codeschool:fetch"].invoke
    Rake::Task["envylabs:fetch"].invoke
    Rake::Task["pluralsight:fetch"].invoke
    Rake::Task["railscasts:fetch"].invoke
    Rake::Task["rubyrogues:fetch"].invoke
    Rake::Task["rubytapas:fetch"].invoke
  end
end