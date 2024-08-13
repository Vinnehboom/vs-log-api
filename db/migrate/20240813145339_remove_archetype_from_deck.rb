class RemoveArchetypeFromDeck < ActiveRecord::Migration[7.1]
  def change
    remove_column :decks, :archetype
  end
end
