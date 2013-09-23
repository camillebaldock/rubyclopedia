Given(/^I have a (free|paid) article(?: from "([^\"]*)")?(?: published on "([^\"]*)")?$/) do |free, supplier, date|
  supplier = Article::ARTICLE_SUPPLIERS.sample.to_s unless supplier
  @article = Article.new_from_supplier(supplier)
  @article.free = free == "free"
  date = Time.at(rand * Time.now.to_i) unless date #Generate random date
  @article.published_at = date
  @article.save
end

When(/^I visit that article's page$/) do
  visit("/articles/#{@article.id}")
end

Then(/^I should see that article's "(.*?)"$/) do |argument|
  step "I should see \"#{@article[argument.to_sym]}\""
end

Then(/^I should see a "(.*?)" link to that article's supplier page$/) do |linked_text|
  step "I should see a \"#{linked_text}\" link to \"#{@article.video_link}\""
end

Then(/^I should not see a "(.*?)" link to that article's supplier page$/) do |linked_text|
  step "I should not see a \"#{linked_text}\" link to \"#{@article.video_link}\""
end

Then /^I should not see a "([^\"]*)" link to "([^\"]*)"$/ do |linked_text, linked_href|
  page.should_not have_css("a", :text => linked_text)
end

Then /^I should see a "([^\"]*)" link to "([^\"]*)"$/ do |linked_text, linked_href|
  page.should have_css("a", :text => linked_text)
end
