class CreateViewedArticles < ActiveRecord::Migration
  def change
    create_table :viewed_articles do |t|
      t.integer :article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
