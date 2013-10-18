=begin
Copyright (C) 2013 Camille Baldock
Rubyclopedia is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.
Rubyclopedia is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
=end
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
