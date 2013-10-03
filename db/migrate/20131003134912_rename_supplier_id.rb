class RenameSupplierId < ActiveRecord::Migration
  def up
  	rename_column :articles, :supplier_id, :supplier_ref
  end

  def down
  	rename_column :articles, :supplier_ref, :supplier_id
  end
end
