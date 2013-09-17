class RubyTapasEpisodes < ActiveRecord::Migration
  def change
  	rename_column :episodes, :slug, :video_link
  	rename_column :episodes, :railscasts_id, :supplier_id
  	add_column :episodes, :free, :boolean 
  end
end
