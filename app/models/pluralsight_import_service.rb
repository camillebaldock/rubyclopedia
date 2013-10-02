=begin
Copyright (C) 2013 Camille_LDN
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
class PluralsightImportService

  def parse_website feed_url="http://pluralsight.com/odata/Courses"
    feed=Nokogiri::XML(open(feed_url)).remove_namespaces!
    feed.css("entry").each do |episode|
      if episode.css("Category").text == "Ruby"
      	episode = Pluralsight.new(
          :name => episode.css("Title").text,
          :free => false,
          :medium => Article.VIDEO,
          :published_at => episode.css("updated").text,
          :description => episode.css("Description").text,
          :video_link=> "http://pluralsight.com/training/Courses/TableOfContents/"+episode.css("Name").text)
        episode.save
      end
    end
  end

end