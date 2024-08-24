class MatchGameSerializer < ActiveModel::Serializer

  attributes :id, :match_id, :result, :started

  belongs_to :match

end
