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
require 'open-uri'
class EnvylabsImportService

  def process
  	pageNumber = 1
    responseEmpty = false
  	until responseEmpty do
  	  doc=Nokogiri::XML(open("http://ruby5.envylabs.com/episodes/page/#{pageNumber}.xml"))
      episodes = doc.css('episode')
  	  process_xml_file episodes
  	  pageNumber += 1
  	  if episodes.count == 0
  	    responseEmpty = true
  	  else 
  		  process_xml_file episodes
      end
    end
  end

  def process_xml_file episodes
    episodes.each do |e|
      episode = Article.new(
        :supplier_ref => e.css('id').text,
        :published_at => e.css('updated-at').text,
        :description => e.css('summary').text,
        :name => e.css('title').text,
        :free => true,
        :supplier => Article::ENVYLABS,
        :medium => Article::AUDIO,
        :video_link => e.css('media-url').text)
      episode.save
    end
  end
end