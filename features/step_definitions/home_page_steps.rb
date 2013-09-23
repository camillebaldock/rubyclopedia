Given /^the following articles exist:?$/ do |articles|
  article_hashes = articles.hashes
  article_hashes.each do |hash|
    hash["supplier"] = Article::ARTICLE_SUPPLIERS.sample.to_s unless hash["supplier"]
  	e = Article.new_from_supplier(hash["supplier"])
    e.name = hash["name"]
    e.published_at = hash["published_at"] || Time.now
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