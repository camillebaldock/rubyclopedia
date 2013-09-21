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
class RubyRoguesImportService

  def parseWebsite url="http://rubyrogues.com/episode-guide/"
    doc=Nokogiri::HTML(open(url))
    episode_links = doc.css('.format_text p a')
    hydra = Typhoeus::Hydra.new
	requests = Array.new
    episode_links.each do |episode_link|
		requests.push(Typhoeus::Request.new(episode_link.attr('href')))
	end
	requests.map { |request| hydra.queue(request) }
	hydra.run
	episodes = Array.new
	requests.each do |request|
		doc = Nokogiri::HTML(request.response.body)
		e = Rubyrogues.new(
              :name => doc.css('.entry-title').text,
              :video_link => request.url,
              :published_at => doc.css('.published').text)
		e.save
	end
  end
end