=begin
Copyright (C) 2013 Camille_LDN
RubyCastsProgressTracker is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.
RubyCastsProgressTracker is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
=end
require 'open-uri'
class KipptImportService

  def parseFeed feedUrl=Settings.kippt.url
    feed=Nokogiri::XML(open(feedUrl))
	feed.xpath('/rss/channel/item').each do |item|
	  e = Kippt.new(
              :name => item.at_xpath('./title').text,
              :published_at => item.at_xpath('./pubDate').text,
			  :description => Nokogiri::HTML(item.at_xpath('./description').text).css('a').attr('href').text,
			  :video_link=>item.at_xpath('./link').text
	    )
	  e.save
	end
  end
end