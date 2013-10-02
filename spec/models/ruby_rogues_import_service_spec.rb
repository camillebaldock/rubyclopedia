require 'spec_helper'

describe RubyRoguesImportService do

  it "parses the episodes HTML page" do
  	rubyrogues = RubyRoguesImportService.new
    rubyrogues.should_receive(:process_response).exactly(:once)
    rubyrogues.parse_website "#{Rails.root}/spec/testdata/EpisodeGuide.html"
  end

  it "parses the HTML page of an individual episode" do
    RubyRoguesImportService.new.process_response open("#{Rails.root}/spec/testdata/001rubyrogues.html"), "url"
    expect(Article.count).to eq(1)
  end

  it "parses the HTML page of individual episodes without duplicates" do
    RubyRoguesImportService.new.process_response open("#{Rails.root}/spec/testdata/001rubyrogues.html"), "url"
    RubyRoguesImportService.new.process_response open("#{Rails.root}/spec/testdata/001rubyrogues.html"), "url"
    expect(Article.count).to eq(1)
  end
end