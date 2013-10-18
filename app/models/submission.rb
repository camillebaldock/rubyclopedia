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
class Submission < ActiveRecord::Base
  attr_accessible :description, :reason, :url, :status
  belongs_to :user
  validates :url, :description, presence: true, allow_blank: false

  def accept
  	self.status = "Accepted"
  	self.save!
  	kind_id = Kind.find_by_name('Teacher').id
    self.user.change_points({ points: 40, kind: kind_id })
  end

  def refuse
  	self.status = "Refused"
  	self.save!
  end
end
