=begin
Copyright (C) 2013 GoldyLDN
RailsCastsProgressTracker is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.
RailsCastsProgressTracker is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
=end
source 'https://rubygems.org'

ruby "2.1.0"

gem 'rails', '~> 3.2.17'
gem 'pg'
gem 'rspec'
gem 'rspec-rails', :group => [:development, :test, :cucumber]
gem 'fakeweb', :group => :test
gem 'coveralls', require: false
gem 'simplecov', ">= 0.8.pre"

group :cucumber do
  gem 'gherkin'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'webmock', require: nil
  gem 'selenium-webdriver'
end

gem 'sass-rails',   '~> 3.2.3'
gem 'compass-rails'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'susy'
  gem 'compass-susy-plugin'
  gem 'jquery-rails'
end

gem 'haml-rails'
gem 'nokogiri'
gem 'typhoeus'
gem 'rails_config'
gem 'whenever'
gem 'chronic'
gem 'timecop'
gem 'tire'
gem 'metric_fu'
gem 'brakeman'
gem 'rails_12factor', group: :production
gem 'devise'
gem 'andand'
gem 'newrelic_rpm'
gem 'gioco'
