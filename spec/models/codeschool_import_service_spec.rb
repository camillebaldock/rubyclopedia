require 'spec_helper'

describe CodeschoolImportService do

  it "process the courses HTML page" do
    CodeschoolImportService.new.process_courses "#{Rails.root}/spec/testdata/codeschoolCourses.html"
    expect(Article.count).to eq(10)
    expect(Article.where(:free => false).count).to eq(8)
    expect(Article.where(:free => true).count).to eq(2)
  end

  it "processes the screencasts HTML page" do
    codeschool = CodeschoolImportService.new
    codeschool.should_receive(:process_response).exactly(31).times
    codeschool.process_screencasts "#{Rails.root}/spec/testdata/codeschoolScreencasts.html"
  end

  it "processes the HTML page of an individual screencast" do
    CodeschoolImportService.new.process_response open("#{Rails.root}/spec/testdata/codeschoolScreencast.html"), "url"
    expect(Article.count).to eq(1)
  end

  it "process the courses HTML page without duplicates" do
    CodeschoolImportService.new.process_courses "#{Rails.root}/spec/testdata/codeschoolCourses.html"
    CodeschoolImportService.new.process_courses "#{Rails.root}/spec/testdata/codeschoolCourses.html"
    expect(Article.count).to eq(10)
  end

  it "processes individual screencasts without duplicates" do
    CodeschoolImportService.new.process_response open("#{Rails.root}/spec/testdata/codeschoolScreencast.html"), "url"
    CodeschoolImportService.new.process_response open("#{Rails.root}/spec/testdata/codeschoolScreencast.html"), "url"
    expect(Article.count).to eq(1)
  end

end
