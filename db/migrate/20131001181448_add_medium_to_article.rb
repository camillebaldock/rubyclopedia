class AddMediumToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :medium, :string
  end
end
