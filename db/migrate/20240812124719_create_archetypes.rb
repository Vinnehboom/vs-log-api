class CreateArchetypes < ActiveRecord::Migration[7.1]
  def change
    create_table :archetypes do |t|
      t.string :identifier,  index: { unique: true }
      t.string :name
      t.integer :priority
      t.integer :generation
      t.json :cards
      t.references :game, null: false, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
