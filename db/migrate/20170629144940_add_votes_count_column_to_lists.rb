class AddVotesCountColumnToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :votes_count, :integer
  end
end