class MatchSerializer < ActiveModel::Serializer

  attributes :id, :list_id, :deck_id, :bo3
  attribute :coinflip_won, if: :bo3

  attributes :result, :remarks, :archetype, :opponent_archetype

  belongs_to :archetype
  belongs_to :opponent_archetype
  has_many :match_games, if: -> { @instance_options[:expand]&.include?(:match_games) }

  attributes :created_at, :updated_at

  delegate :bo3, to: :object

end
