class DeckSerializer < ActiveModel::Serializer

  attributes :id, :name, :active, :game_id, :user_id, :active, :created_at, :updated_at

  belongs_to :archetype

end
