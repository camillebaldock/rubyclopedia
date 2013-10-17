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

  def score
    self.points.sum(:value)
  end
end