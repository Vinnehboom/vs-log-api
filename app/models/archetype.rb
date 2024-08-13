class Archetype < ApplicationRecord

  belongs_to :game
  has_many :decks, dependent: :restrict_with_error
  has_many :match_records, dependent: :restrict_with_error
  has_many :opponent_match_records, foreign_key: :opponent_archetype_id,
                                    class_name: 'MatchRecord',
                                    inverse_of: :opponent_archetype,
                                    dependent: :restrict_with_error
  validates :identifier, presence: true
  validates :name, presence: true
  validates :identifier, uniqueness: true
  has_many_attached :icons

end
