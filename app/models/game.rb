class Game < ApplicationRecord

  has_many :archetypes, dependent: :destroy
  has_many :decks, dependent: :restrict_with_exception

  validates :name, presence: true

  def card_count_valid(count:)
    minimum_count = deck_card_count <= count

    return minimum_count unless exact_count

    deck_card_count == count
  end

end
