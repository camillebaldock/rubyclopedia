Given /^the following episodes exist:?$/ do |episodes|
  episode_hashes = episodes.hashes
  episode_hashes.each do |hash|
  	e = Episode.new_from_provider(hash["provider"])
    e.name = hash["name"]
    e.published_at = hash["published_at"]
    e.save
  end
end

Given /^the date is "([^"]*)"$/ do |date_string|
  Timecop.freeze Chronic.parse("#{date_string} at noon")
end

Then /^I should see the following:?$/ do |table|
  table.raw.each do |text|
    step "I should see \"#{text[0]}\""
  end
end