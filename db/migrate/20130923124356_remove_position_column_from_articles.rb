class RemovePositionColumnFromArticles < ActiveRecord::Migration
  def change
  	remove_column :articles, :position
  end
end
