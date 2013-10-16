require 'spec_helper'

describe RailsCastsImportService do

  it "parses JSON with one episode, H:MM duration" do
    RailsCastsImportService.new.process_json_file "#{Rails.root}/spec/testdata/OneEpisodeHMM.json"
    expect(Article.count).to eq(1)
  end

  it "parses JSON with two episodes" do
    RailsCastsImportService.new.process_json_file "#{Rails.root}/spec/testdata/TwoEpisodes.json"
    expect(Article.count).to eq(2)
  end

  it "parses JSON without duplicates" do
    RailsCastsImportService.new.process_json_file "#{Rails.root}/spec/testdata/OneEpisodeHHMM.json"
    RailsCastsImportService.new.process_json_file "#{Rails.root}/spec/testdata/OneEpisodeHHMM.json"
    expect(Article.count).to eq(1)
  end
end
