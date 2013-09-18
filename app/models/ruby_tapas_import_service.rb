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
class RubyTapasImportService

  def parseWebsite
    if Settings.rubytapas.paid
      parseWebsitePaid
    else
      parseWebsiteFree
    end
  end

  def parseWebsitePaid feedUrl="https://rubytapas.dpdcart.com/feed", webUrl = "http://www.rubytapas.com/episodes"
    doc=Nokogiri::HTML(open(webUrl))
    free_episodes = doc.css('.free')
	free_ids = Array.new
	free_episodes.each do |episode|
		free_ids.push /(\d{1,3})\..*/.match(episode.css('a h4').text)[1].to_i
	end

    feed=Nokogiri::XML(open(feedUrl, :http_basic_authentication=>[Settings.rubytapas.user, Settings.rubytapas.password]))
	feed.xpath('/rss/channel/item').each do |item|
	  title = item.at_xpath('./title').text
	  if title.sub!(/^(\d+):?\s+/, '')
	    title.strip!
	    episode_id = $1.to_i
	    e = Rubytapas.new(
              :name => title.gsub(/\W+/, '-').gsub(/^-|-$/, ''),
              :published_at => item.at_xpath('./pubDate').text,
			  :description => Nokogiri::HTML(item.at_xpath('./description').text).css('.blog-content p').text,
			  :video_link=>item.at_xpath('./enclosure').attr('url'),
			  :free => (free_ids.include? episode_id),
			  :supplier_id=>episode_id
	    )
	    e.save
	  end
	end
  end

  def parseWebsiteFree webUrl = "http://www.rubytapas.com/episodes"
  	doc=Nokogiri::HTML(open(webUrl))
    free_episodes = doc.css('.free')
	free_episodes.each do |episode|
		name = episode.css('a h4').text
		e = Rubytapas.new(
              :name => name,
              :published_at => Time.now,
			  :description => episode.css('p').text,
			  :video_link=>episode.css('a').attr('href').text,
			  :free => true,
			  :supplier_id=>/(\d{1,3})\..*/.match(name)[1].to_i
	    )
	    e.save
	end
  end
end