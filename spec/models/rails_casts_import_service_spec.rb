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
