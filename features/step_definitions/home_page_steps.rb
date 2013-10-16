Given /^the following articles exist:?$/ do |articles|
  article_hashes = articles.hashes
  article_hashes.each do |hash|
    hash["supplier"] ||= Article::SUPPLIERS.sample
    hash["medium"] ||= Article::MEDIA.sample
  	a = Article.new
    a.supplier = hash["supplier"]
    a.medium = hash["medium"]
    a.name = hash["name"]
    a.published_at = hash["published_at"] || Time.now
    a.save!
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