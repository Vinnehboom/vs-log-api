class CreateMatchGames < ActiveRecord::Migration[7.1]
  def change
    create_table :match_games, id: :uuid do |t|
      t.references :match, null: false, foreign_key: true, type: :uuid
      t.string :result
      t.boolean :started, default: false

      t.timestamps
    end

  end
end
