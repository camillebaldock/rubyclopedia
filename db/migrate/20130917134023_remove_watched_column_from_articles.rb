class RemoveWatchedColumnFromArticles < ActiveRecord::Migration
  def change
  	remove_column :articles, :watched
  end
end
