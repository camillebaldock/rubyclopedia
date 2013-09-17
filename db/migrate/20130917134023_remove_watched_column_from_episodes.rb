class RemoveWatchedColumnFromEpisodes < ActiveRecord::Migration
  def change
  	remove_column :episodes, :watched
  end
end
