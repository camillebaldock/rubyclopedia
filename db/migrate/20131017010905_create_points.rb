class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :user_id
      t.integer :kind_id
      t.integer :value

      t.timestamps
    end
  end
end
