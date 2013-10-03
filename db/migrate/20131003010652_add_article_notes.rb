class AddArticleNotes < ActiveRecord::Migration
  def change
    create_table :article_notes do |t|
      t.integer :article_id
      t.integer :user_id
      t.text :notes
      t.timestamps
    end
  end
end
