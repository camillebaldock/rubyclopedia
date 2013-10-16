class AddSuperuserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superuser, :boolean
  end
end
