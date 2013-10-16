class Submission < ActiveRecord::Base
  attr_accessible :description, :reason, :url
  belongs_to :user
  validates :url, :description, presence: true, allow_blank: false
end
