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
class Episode < ActiveRecord::Base
  attr_accessible :description, :name, :published_at, :video_link
  scope :recent, lambda { where("published_at >= :date", :date => 1.month.ago) }
  scope :old, lambda { where("published_at < :date", :date => 1.month.ago) }

  EPISODE_PROVIDERS = []

  def self.inherited subclass
    EPISODE_PROVIDERS << subclass
    super
  end

  def self.new_episode_from_provider provider
    EPISODE_PROVIDERS.detect{|t| (t.to_s == provider)}.new
  end
end
