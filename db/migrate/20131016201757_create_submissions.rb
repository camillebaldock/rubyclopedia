class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :url
      t.text :description
      t.text :reason
      t.belongs_to :user
      t.timestamps
    end
  end
end
