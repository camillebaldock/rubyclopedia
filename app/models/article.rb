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
class Article < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name BONSAI_INDEX_NAME

  def self.search(params)
    tire.search(load: true) do
      query { string "*#{params[:search]}*", default_operator: "OR" } if params[:search].present?
    end
  end

  SUPPLIERS = [CODECADEMY = 'Codecademy', 
           CODESCHOOL = 'Codeschool', 
           ENVYLABS = 'Envylabs', 
           PLURALSIGHT = 'Pluralsight', 
           RAILSCASTS = 'Railscasts', 
           RUBYROGUES = 'Rubyrogues',
           RUBYTAPAS = 'Rubytapas']
  MEDIA = [AUDIO = 'Audio',
           COURSE = 'Course',
           VIDEO = 'Video']

  validates :supplier, inclusion: {in: SUPPLIERS}
  validates :medium, inclusion: {in: MEDIA}

  letsrate_rateable "quality"

  attr_accessible :description, :name, :published_at, :video_link, :supplier_ref, :free, :medium, :supplier, :duration_seconds
  validates_uniqueness_of :name, :scope => [:supplier]
  scope :recent, lambda { where("published_at >= :date", :date => 1.month.ago) }
  scope :old, lambda { where("published_at < :date", :date => 1.month.ago) }
  scope :notcourse, lambda { where("medium != :course", :course => Article::COURSE) }
  scope :course, lambda { where("medium = :course", :course => Article::COURSE) }

end
