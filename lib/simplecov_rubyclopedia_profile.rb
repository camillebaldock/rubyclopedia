require 'simplecov'
SimpleCov.profiles.define 'rubyclopedia' do
  load_profile 'rails'
  add_filter '/spec'
  add_filter '/features'
end