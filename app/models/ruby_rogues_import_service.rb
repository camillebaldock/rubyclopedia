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
class RubyRoguesImportService

  def parse_website url="http://rubyrogues.com/episode-guide/"
    doc=Nokogiri::HTML(open(url))
    episode_links = doc.css('.format_text p a')
    hydra = Typhoeus::Hydra.new
    requests = Array.new
    episode_links.each do |episode_link|
      requests.push(Typhoeus::Request.new(episode_link.attr('href')))
    end
    requests.map { |request| hydra.queue(request) }
    hydra.run
    requests.each do |request|
      process_response request.response.body, request.url
    end
  end

  def process_response response, url
    doc = Nokogiri::HTML(response)
    title = doc.css('.entry-title').text
    name_regex_matches = /(\d{3}) RR (.*)/.match(title)
    name_regex_matches = /RR (\d{2,3}) (.*)/.match(title) unless name_regex_matches
    name_regex_matches = /(\d{3}) \S (.*)/.match(title) unless name_regex_matches
    if name_regex_matches
      episode = Article.new(
        :name => name_regex_matches[2],
        :medium => Article::AUDIO,
        :supplier => Article::RUBYROGUES,
        :supplier_ref => name_regex_matches[1].to_i,
        :video_link => url,
        :published_at => doc.css('.published').text,
        :free=>true)
      episode.save
    end
  end
end