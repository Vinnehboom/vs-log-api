class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches, id: :uuid do |t|
      t.references :list, null: true, foreign_key: true, type: :uuid
      t.references :deck, null: true, foreign_key: true, type: :uuid
      t.references :opponent_archetype, null: false
      t.references :archetype, null: false
      t.boolean :bo3
      t.boolean :coinflip_won
      t.string :remarks
      t.string :result

      t.timestamps
    end

    add_foreign_key "matches", "archetypes", column: "opponent_archetype_id"
    add_foreign_key "matches", "archetypes", column: "archetype_id"

  end
end
