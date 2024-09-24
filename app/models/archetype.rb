class Archetype < ApplicationRecord

  default_scope -> { includes(icons_attachments: :blob) }
  scope :other, -> { where(identifier: 'other') }
  belongs_to :game
  has_many :decks, dependent: :restrict_with_error
  has_many :matches, dependent: :restrict_with_error
  has_many :opponent_matches, foreign_key: :opponent_archetype_id,
                              class_name: 'Match',
                              inverse_of: :opponent_archetype,
                              dependent: :restrict_with_error
  validates :identifier, presence: true
  validates :name, presence: true
  validates :identifier, uniqueness: true
  has_many_attached :icons

end
