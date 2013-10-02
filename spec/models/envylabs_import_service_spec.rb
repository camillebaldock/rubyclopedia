require 'spec_helper'

describe EnvylabsImportService do

  it "processes an XML page" do
  	doc=Nokogiri::XML(open("#{Rails.root}/spec/testdata/envylabsFeed"))
    episodes = doc.css('episode')
    EnvylabsImportService.new.process_xml_file episodes
    expect(Article.count).to eq(20)
  end

  it "processes an XML page without duplicates" do
  	doc=Nokogiri::XML(open("#{Rails.root}/spec/testdata/envylabsFeed"))
    episodes = doc.css('episode')
    EnvylabsImportService.new.process_xml_file episodes
    EnvylabsImportService.new.process_xml_file episodes
    expect(Article.count).to eq(20)
  end
end
