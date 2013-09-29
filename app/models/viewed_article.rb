class ViewedArticle < ActiveRecord::Base
  attr_accessible :article_id, :user_id
  belongs_to :article
  belongs_to :user
end
