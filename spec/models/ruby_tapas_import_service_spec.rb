require 'spec_helper'

describe RubyTapasImportService do

  it "parses the XML feed, and parses the HTML page to detect which episodes are free" do
    RubyTapasImportService.new.parse_website_paid "#{Rails.root}/spec/testdata/rubyTapasFeed", "#{Rails.root}/spec/testdata/rubyTapasPage.html"
    expect(Article.count).to eq(134)
    expect(Article.where(:free => false).count).to eq(118)
    expect(Article.where(:free => true).count).to eq(16)
  end

  it "parses the HTML page for free episodes" do
    RubyTapasImportService.new.parse_website_free "#{Rails.root}/spec/testdata/rubyTapasPage.html"
    expect(Article.count).to eq(16)
    expect(Article.where(:free => true).count).to eq(16)
  end

  it "parses the HTML page for free episodes without duplicates" do
    RubyTapasImportService.new.parse_website_free "#{Rails.root}/spec/testdata/rubyTapasPage.html"
    RubyTapasImportService.new.parse_website_free "#{Rails.root}/spec/testdata/rubyTapasPage.html"
    expect(Article.count).to eq(16)
  end
end
