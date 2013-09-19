Given(/^I have a (free|paid) episode(?: from "([^\"]*)")?(?: published on "([^\"]*)")?$/) do |free, provider, date|
  provider = Episode::EPISODE_PROVIDERS.sample.to_s unless provider
  @episode = Episode.new_from_provider(provider)
  @episode.free = free == "free"
  date = Time.at(rand * Time.now.to_i) unless date #Generate random date
  @episode.published_at = date
  @episode.save
end

When(/^I visit that episode's page$/) do
  visit("/episodes/#{@episode.id}")
end

Then(/^I should see that episode's "(.*?)"$/) do |argument|
  step "I should see \"#{@episode[argument.to_sym]}\""
end

Then(/^I should see a "(.*?)" link to that episode's supplier page$/) do |linked_text|
  step "I should see a \"#{linked_text}\" link to \"#{@episode.video_link}\""
end

Then(/^I should not see a "(.*?)" link to that episode's supplier page$/) do |linked_text|
  step "I should not see a \"#{linked_text}\" link to \"#{@episode.video_link}\""
end

Then /^I should not see a "([^\"]*)" link to "([^\"]*)"$/ do |linked_text, linked_href|
  page.should_not have_css("a", :text => linked_text)
end

Then /^I should see a "([^\"]*)" link to "([^\"]*)"$/ do |linked_text, linked_href|
  page.should have_css("a", :text => linked_text)
end
