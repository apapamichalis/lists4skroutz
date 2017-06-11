class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name, default: "My List"
      t.boolean :active, default: true
      add_foreign_key :users
      t.timestamps
    end
  end
end
