When /^I search for "([^"]*)"$/ do |query|
  fill_in 'search', with: query
  find('#search').native.send_keys(:return)
end

Then /^I should see a message indicating no articles were found$/ do
  within('section.posts') do
    page.should have_content('No articles were found')
  end
end