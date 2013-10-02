require 'spec_helper'

describe CodecademyImportService do

  it "processes JSON feed" do
    CodecademyImportService.new.process_json_file "#{Rails.root}/spec/testdata/codecademyFeed"
    expect(Article.count).to eq(19)
  end

  it "processes JSON feed without duplicates" do
    CodecademyImportService.new.process_json_file "#{Rails.root}/spec/testdata/codecademyFeed"
    CodecademyImportService.new.process_json_file "#{Rails.root}/spec/testdata/codecademyFeed"
    expect(Article.count).to eq(19)
  end
end
