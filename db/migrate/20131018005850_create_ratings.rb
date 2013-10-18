class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.belongs_to :user
      t.belongs_to :article
      t.integer :stars, :null => false
      t.string :kind
      t.timestamps
    end
    
    add_index :ratings, :user_id
    add_index :ratings, :article_id
  end

  def self.down
    drop_table :ratings
  end
end
