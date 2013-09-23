class RubyTapasArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :slug, :video_link
    rename_column :articles, :railscasts_id, :supplier_id
    add_column :articles, :free, :boolean
  end
end
