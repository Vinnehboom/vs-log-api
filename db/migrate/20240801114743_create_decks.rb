class CreateDecks < ActiveRecord::Migration[7.1]
  def change
    create_table :decks, id: :uuid do |t|
      t.string :name
      t.string :user_id
      t.json :archetype

      t.timestamps
    end
  end
end
