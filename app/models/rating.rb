class Rating < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  attr_accessible :article_id, :user_id, :stars, :kind
end
