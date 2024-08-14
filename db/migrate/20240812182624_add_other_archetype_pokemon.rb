class AddOtherArchetypePokemon < ActiveRecord::Migration[7.1]

  class Game < ActiveRecord::Base
    self.table_name = 'games'
    has_many :archetypes
  end

  class Archetype < ActiveRecord::Base
    self.table_name = 'archetypes'
    belongs_to :game
  end

  def up
    game = Game.find_or_create_by(id: "PTCG", name: "Pokémon TCG")
    other = Archetype.find_or_initialize_by(
      name: "Other",
      identifier: "other",
      cards: [],
      game:)
    other.save!
  end

  def down
    game = Game.find("PTCG")
    Archetype.find_by(game:, identifier: "other").destroy
  end
end
