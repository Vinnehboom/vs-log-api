class Archetype < ApplicationRecord

  belongs_to :game
  has_many :decks, dependent: nil
  validates :identifier, presence: true
  validates :name, presence: true
  validates :identifier, uniqueness: true
  has_many_attached :icons

end
