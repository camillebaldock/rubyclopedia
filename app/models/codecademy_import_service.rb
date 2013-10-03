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
class CodecademyImportService

  def process_json_file json_file = "http://www.codecademy.com/tracks/ruby.json"
    episodes_json = open(json_file)
    parsed_json = ActiveSupport::JSON.decode(episodes_json)
    parsed_json["units"].each do |units_json|
      units_json["courses"].each do |episode_json|
        create_from_json(episode_json)
      end
    end
  end

  def create_from_json json_episode
    episode = Article.new(
        :free => true,
        :supplier => Article::CODECADEMY,
        :name => json_episode["name"],
        :description => json_episode["entry"],
        :medium => Article::COURSE,
        :video_link => json_episode["url"])
    episode.save
  end
end