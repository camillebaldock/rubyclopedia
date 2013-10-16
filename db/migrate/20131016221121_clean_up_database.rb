class CleanUpDatabase < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :rates
    drop_table :rating_caches
    add_index :users, :username
    remove_column :articles, :duration_seconds
    remove_column :submissions, :reason
  end
end
