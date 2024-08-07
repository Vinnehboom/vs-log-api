class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists, id: :uuid do |t|
      t.references :deck, null: false, foreign_key: true, type: :uuid
      t.json :cards
      t.string :name

      t.timestamps
    end
  end
end
