class AddDeckCardCountAttributesToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :deck_card_count, :integer, default: 60
    add_column :games, :exact_count, :boolean, default: false
  end
end
