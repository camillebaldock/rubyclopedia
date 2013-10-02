require 'spec_helper'

describe PluralsightImportService do

  it "processes the XML feed" do
    PluralsightImportService.new.parse_website "#{Rails.root}/spec/testdata/pluralsightFeed"
    expect(Article.count).to eq(9)
  end

  it "processes the XML feed without duplicates" do
    PluralsightImportService.new.parse_website "#{Rails.root}/spec/testdata/pluralsightFeed"
    PluralsightImportService.new.parse_website "#{Rails.root}/spec/testdata/pluralsightFeed"
    expect(Article.count).to eq(9)
  end
end
