class Kind < ActiveRecord::Base
has_many :badges  
has_many :points  
validates :name, :presence => true
validates :name, :uniqueness => true
  attr_accessible :name
end
