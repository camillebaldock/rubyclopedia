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
