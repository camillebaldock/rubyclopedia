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
class Badge < ActiveRecord::Base
belongs_to :kind  
has_many :users , :through => :levels 
has_many :levels  , :dependent => :destroy
validates :name, :presence => true

def add(resource_id)
  resource = Gioco::Core.get_resource(resource_id)

  if Gioco::Core::POINTS && !resource.badges.include?(self)
    if Gioco::Core::KINDS
      Gioco::Core.sync_resource_by_points(resource, self.points, self.kind)
    else
      Gioco::Core.sync_resource_by_points(resource, self.points)
    end
  elsif !resource.badges.include?(self)
    resource.badges << self
    return self
  end
end

def remove(resource_id)
  resource = Gioco::Core.get_resource(resource_id)

  if Gioco::Core::POINTS && resource.badges.include?(self)
    if Gioco::Core::KINDS
      kind       = self.kind
      badges_gap = Badge.where( "points < #{self.points} AND kind_id = #{kind.id}" ).order('points DESC')[0]
      Gioco::Core.sync_resource_by_points( resource, ( badges_gap.nil? ) ? 0 : badges_gap.points, kind)
    else
      badges_gap = Badge.where( "points < #{self.points}" ).order('points DESC')[0]
      Gioco::Core.sync_resource_by_points( resource, ( badges_gap.nil? ) ? 0 : badges_gap.points)
    end
  elsif resource.badges.include?(self)
    resource.levels.where( :badge_id => self.id )[0].destroy
    return self
  end
end
  attr_accessible :default, :kind_id, :name, :points
end
