When /^I search for "([^"]*)"$/ do |query|
  fill_in 'search', with: query
  step "I send enter to \"#search\""
end

Then /^I should see a message indicating no articles were found$/ do
  within('section.posts') do
    page.should have_content('No articles were found')
  end
end

Then(/^I should see the article called "(.*?)" in the article list$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not see the article called "(.*?)" in the article list$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end