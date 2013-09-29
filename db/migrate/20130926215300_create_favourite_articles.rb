class CreateFavouriteArticles < ActiveRecord::Migration
  def change
    create_table :favourite_articles do |t|
      t.integer :article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
