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
class RubyTapasImportService

  def parse_website
    if Settings.rubytapas.paid
      parse_website_paid
    else
      parse_website_free
    end
  end

  def parse_website_paid feed_url="https://rubytapas.dpdcart.com/feed", web_url = "http://www.rubytapas.com/episodes"
    doc=Nokogiri::HTML(open(web_url))
    free_episodes = doc.css('.free')
    free_ids = Array.new
    free_episodes.each do |episode|
      free_ids.push /(\d{1,3})\..*/.match(episode.css('a h4').text)[1].to_i
    end

    user = Settings.rubytapas.andand.user || ENV['RUBYTAPAS_USER']
    password = Settings.rubytapas.andand.user || ENV['RUBYTAPAS_PASSWORD']
    feed=Nokogiri::XML(open(feed_url, :http_basic_authentication=>[user, password]))
    feed.xpath('/rss/channel/item').each do |item|
      title = item.at_xpath('./title').text
      if title.sub!(/^(\d+):?\s+/, '')
        title.strip!
        episode_id = $1.to_i
        episode = Article.new(
          :name => title.gsub(/\W+/, '-').gsub(/^-|-$/, ''),
          :published_at => item.at_xpath('./pubDate').text,
          :description => Nokogiri::HTML(item.at_xpath('./description').text).css('.blog-content p').text,
          :video_link=>item.at_xpath('./enclosure').attr('url'),
          :free => (free_ids.include? episode_id),
          :supplier_ref=>episode_id,
          :supplier => Article::RUBYTAPAS,
          :medium => Article::VIDEO
        )
        episode.save
      end
    end
  end

  def parse_website_free web_url = "http://www.rubytapas.com/episodes"
    doc=Nokogiri::HTML(open(web_url))
    free_episodes = doc.css('.free')
    free_episodes.each do |episode|
      name = episode.css('a h4').text
      episode = Article.new(
        :name => name,
        :published_at => Time.now,
        :description => episode.css('p').text,
        :video_link=>episode.css('a').attr('href').text,
        :free => true,
        :supplier => Article::RUBYTAPAS,
        :medium => Article::VIDEO,
        :supplier_ref=>/(\d{1,3})\..*/.match(name)[1].to_i)
      episode.save
    end
  end
end