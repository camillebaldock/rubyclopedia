class RenameTypeColumn < ActiveRecord::Migration
  def up
  	rename_column :articles, :type, :supplier
  end

  def down
  	rename_column :articles, :supplier, :type
  end
end
