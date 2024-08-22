class ArchetypeSerializer < ActiveModel::Serializer

  attributes :id, :name, :identifier, :priority, :generation, :game_id, :cards

end
