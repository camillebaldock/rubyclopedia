class CleanUpDatabase < ActiveRecord::Migration
  def change
    drop_table :tags
    add_index :users, :username
    remove_column :articles, :duration_seconds
    remove_column :submissions, :reason
  end
end
