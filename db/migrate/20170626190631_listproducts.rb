class Listproducts < ActiveRecord::Migration[5.0]
  def change
  	create_table :listproducts do |t|
  		t.references :list, foreign_key: true
      t.string :skuid
    end
    add_index :listproducts, [:list_id, :skuid], :unique => true 
  end
end