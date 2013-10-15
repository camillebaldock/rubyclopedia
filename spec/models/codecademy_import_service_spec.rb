require 'spec_helper'

describe CodecademyImportService do

  it "processes JSON feed" do
    CodecademyImportService.new.process_courses "#{Rails.root}/spec/testdata/codecademy.html"
    expect(Article.count).to eq(19)
  end

  it "processes JSON feed without duplicates" do
    CodecademyImportService.new.process_courses "#{Rails.root}/spec/testdata/codecademy.html"
    CodecademyImportService.new.process_courses "#{Rails.root}/spec/testdata/codecademy.html"
    expect(Article.count).to eq(19)
  end
end
