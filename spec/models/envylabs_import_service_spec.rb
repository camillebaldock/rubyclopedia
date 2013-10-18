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
