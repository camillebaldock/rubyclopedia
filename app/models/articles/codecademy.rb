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
class Codecademy < Article

  attr_accessible :duration_seconds

  def self.model_name
    Article.model_name
  end

  def self.new_from_json json_episode
    episode = self.new(
        :free => true,
        :name => json_episode["name"],
        :description => json_episode["entry"],
        :medium => Article.COURSE,
        :video_link => json_episode["url"])
    episode.save
  end

end
