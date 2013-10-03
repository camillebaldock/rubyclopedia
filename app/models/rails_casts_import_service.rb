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
class RailsCastsImportService

  def process_json_file json_file = "http://railscasts.com/episodes.json"
    episodes_json = open(json_file)
    parsed_json = ActiveSupport::JSON.decode(episodes_json)
    parsed_json.each do |episode_json|
      create_from_json(episode_json)
    end
  end

  def create_from_json json_episode
    duration_regex_matches = /(\d{1,2}):(\d{2})/.match(json_episode["duration"])
    duration_in_seconds = duration_regex_matches[1].to_i*60 + duration_regex_matches[2].to_i
    episode = Article.new(
        :supplier_id => json_episode["position"],
        :free => !json_episode["pro"],
        :name => json_episode["name"],
        :medium => Article::VIDEO,
        :supplier => Article::RAILSCASTS,
        :description => json_episode["description"],
        :published_at => json_episode["published_at"],
        :duration_seconds => duration_in_seconds,
        :video_link => json_episode["url"].chomp('.json'))
    episode.save
  end
end