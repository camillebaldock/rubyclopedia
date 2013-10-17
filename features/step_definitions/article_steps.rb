Given(/^I have a(?:( free| paid))? article(?: from "([^\"]*)")?(?: published on "([^\"]*)")??(?: of type "([^\"]*)")?$/) do |free, supplier, date, medium|
  supplier ||= Article::SUPPLIERS.sample
  medium ||= Article::MEDIA.sample
  date ||= Time.at(rand * Time.now.to_i) #Generate random date if no date specified
  @article = Article.new
  @article.name = rand(36**5).to_s(36)
  @article.supplier = supplier
  @article.medium = medium
  @article.free = free == " free"
  @article.published_at = date
  @article.save!
end

Given(/^I have marked this article as viewed$/) do
  @user.viewed << @article
end

Given(/^I have marked this article as favourite$/) do
  @user.favourites << @article
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
