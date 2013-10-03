class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  letsrate_rater

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :favourite_articles
  has_many :favourites, through: :favourite_articles, source: :article

  has_many :viewed_articles
  has_many :viewed, through: :viewed_articles, source: :article

  has_many :article_notes

end