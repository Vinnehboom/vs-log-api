class AddActiveToDeck < ActiveRecord::Migration[7.1]
  def change
    add_column :decks, :active, :boolean, default: false
    add_index :decks, [:user_id, :active], unique: true, where: '(active IS TRUE)'
  end
end
