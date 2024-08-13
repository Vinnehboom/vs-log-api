class AddArchetypeToDeck < ActiveRecord::Migration[7.1]
  def change
    add_reference :decks, :archetype, null: false, foreign_key: true
  end
end
