class AddGlcArchetypesPokemon < ActiveRecord::Migration[7.1]

  class Game < ActiveRecord::Base
    self.table_name = 'games'
    has_many :archetypes
  end

  class Archetype < ActiveRecord::Base
    self.table_name = 'archetypes'
    belongs_to :game
    has_many_attached :icons

  end


  def up

    game = Game.find_or_create_by(id: "PTCG", name: "Pokémon TCG")
    glc_types = %w[colorless lightning fighting water grass fire metal psychic dragon fairy dark]

    glc_archetypes = glc_types.map do |type|
      {
        identifier: type,
        game:,
        name: type.capitalize,
        priority: 10,
        cards: [],
        generation: 10,
      }
    end
    glc_archetypes.each do |archetype|
       Archetype.find_or_create_by(archetype)
    end

  end

  def down
    game = Game.find("PTCG")
    glc_types = %w[colorless lightning fighting water grass fire metal psychic dragon fairy dark]
    glc_types.each do |type|
      Archetype.find_by(game:, identifier: type).destroy
    end
  end
end
