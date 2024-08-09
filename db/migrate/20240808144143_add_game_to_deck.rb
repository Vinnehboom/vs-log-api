class AddGameToDeck < ActiveRecord::Migration[7.1]
  def change
    add_reference :decks, :game, null: false, foreign_key: true, type: :string
  end
end
