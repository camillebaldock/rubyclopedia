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
class CodeschoolImportService

  def process_screencasts url = "https://www.codeschool.com/code_tv?filters%5Bpath%5D=ruby"
  	doc=Nokogiri::HTML(open(url))
    screencasts = doc.css('h4.bucket-header b a')
    hydra = Typhoeus::Hydra.new
    requests = Array.new
    screencasts.each do |screencast|
      requests.push(Typhoeus::Request.new("http://www.codeschool.com" + screencast.andand.attr('href')))
    end
    requests.map { |request| hydra.queue(request) }
    hydra.run
    requests.each do |request|
      process_response request.response.body, request.url
    end
  end

  def process_courses url = "https://www.codeschool.com/paths/ruby"
    doc=Nokogiri::HTML(open(url))
    rubycourses = doc.css('div.path-ruby')
    courses = rubycourses.css('article.course')
    courses.each do |course|
      episode = Article.new(
        :name => course.css('div.bucket-content a h3 b').text,
        :free => (course.css('em.label-b').count > 0),
        :medium => Article::COURSE,
        :supplier => Article::CODESCHOOL,
        :description => course.css('div.bucket-content a p').text,
        :video_link=> "http://www.codeschool.com" + course.css('div.bucket-content a').attr('href').text)
      episode.save
    end
  end

  def process_response response, url
    doc = Nokogiri::HTML(response)
    episode = Article.new(
      :name => doc.css('div.video-info h1').text,
      :free => false,
      :supplier => Article::CODESCHOOL,
      :medium => Article::VIDEO,
      :description => doc.css('div.video-desc p')[1].andand.text,
      :video_link=> url)
    episode.published_at = doc.css('ul.meta li time').attr('datetime').value unless doc.css('ul.meta li time').empty?
    episode.save
  end
end