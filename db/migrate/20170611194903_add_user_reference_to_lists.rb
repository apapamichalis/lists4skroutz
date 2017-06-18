class AddUserReferenceToLists < ActiveRecord::Migration[5.0]
  def change
    change_table :lists do |t|
      t.references :user, foreign_key: true
    end
  end
end
