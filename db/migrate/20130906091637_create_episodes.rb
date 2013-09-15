class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.string :type
      t.text :description
      t.timestamp :published_at
      t.integer :position
      t.integer :duration_seconds
      t.integer :railscasts_id
      t.string :slug
      t.boolean :watched, :default => false
      t.timestamps
    end
  end
end
