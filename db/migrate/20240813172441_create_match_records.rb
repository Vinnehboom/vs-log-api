class CreateMatchRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :match_records, id: :uuid do |t|
      t.references :list, null: false, foreign_key: true, type: :uuid
      t.references :deck, null: false, foreign_key: true, type: :uuid
      t.references :opponent_archetype, null: false
      t.references :archetype, null: false
      t.boolean :bo3
      t.boolean :coinflip_won
      t.string :remarks
      t.string :result

      t.timestamps
    end

    add_foreign_key "match_records", "archetypes", column: "opponent_archetype_id"
    add_foreign_key "match_records", "archetypes", column: "archetype_id"

  end
end
