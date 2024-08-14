class Game < ApplicationRecord

  has_many :archetypes, dependent: :destroy
  has_many :decks, dependent: :restrict_with_exception

  validates :name, presence: true

end
