class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.references :list, type: :uuid, null: false, foreign_key: true
      t.integer :count
      t.string :name
      t.string :set_id
      t.string :set_number

      t.timestamps
    end

    ActiveRecord::Base.transaction do
      List.all.each do |list|
        db_cards = list.cards.map do |cards|
          next unless cards.is_a?(Hash)

          {
            count: cards["count"],
            name: cards["card"]["name"],
            set_id: cards["card"]["setId"],
            set_number: cards["card"]["setNumber"],
            list:
          }
        end
        db_cards&.compact.each do |card|
          card = Card.new(card.merge(list:))
          card.save(validate: false)
        end

        list.save!

      end
    end

    remove_column :lists, :cards
  end
end
