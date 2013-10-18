class User < ActiveRecord::Base
  has_many :points  
  has_many :badges , :through => :levels 
  has_many :levels

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  validates_uniqueness_of :username, :case_sensitive => false
  has_many :favourite_articles
  has_many :favourites, through: :favourite_articles, source: :article

  has_many :viewed_articles
  has_many :viewed, through: :viewed_articles, source: :article

  has_many :article_notes

  has_many :ratings

  def score
    self.points.sum(:value)
  end

  def change_points(options)
    if Gioco::Core::KINDS
      points = options[:points]
      kind   = Kind.find(options[:kind])
    else
      points = options
      kind   = false
    end

    if Gioco::Core::KINDS
      raise "Missing Kind Identifier argument" if !kind
      old_pontuation = self.points.where(:kind_id => kind.id).sum(:value)
    else
      old_pontuation = self.points.to_i
    end
    new_pontuation = old_pontuation + points
    Gioco::Core.sync_resource_by_points(self, new_pontuation, kind)
  end

  def next_badge?(kind_id = false)
    if Gioco::Core::KINDS
      raise "Missing Kind Identifier argument" if !kind_id
      old_pontuation = self.points.where(:kind_id => kind_id).sum(:value)
    else
      old_pontuation = self.points.to_i
    end
    next_badge       = Badge.where("points > #{old_pontuation}").order("points ASC").first
    last_badge_point = self.badges.last.try('points')
    last_badge_point ||= 0

    if next_badge
      percentage      = (old_pontuation - last_badge_point)*100/(next_badge.points - last_badge_point)
      points          = next_badge.points - old_pontuation
      next_badge_info = {
                        :badge      => next_badge,
                        :points     => points,
                        :percentage => percentage
                      }
    end
  end
end