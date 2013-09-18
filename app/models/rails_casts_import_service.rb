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
class RailsCastsImportService

  def processJsonFile jsonFile = "http://railscasts.com/episodes.json"
    episodes_json = open(jsonFile)
    parsed_json = ActiveSupport::JSON.decode(episodes_json)
    parsed_json.each do |episode|
      duration_regex_matches = /(\d{1,2}):(\d{2})/.match(episode["duration"])
      duration_in_seconds = duration_regex_matches[1].to_i*60 + duration_regex_matches[2].to_i
      e = Railscasts.new(
                      :supplier_id => episode["id"],
                      :free => !episode["pro"],
                      :name => episode["name"],
                      :position => episode["position"],
                      :description => episode["description"],
                      :published_at => episode["published_at"],
                      :duration_seconds => duration_in_seconds,
                      :video_link => episode["url"].chomp('.json'))
      e.save
    end
  end

end