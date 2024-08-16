class List < ApplicationRecord

  before_validation :ensure_single_deck_active, if: :active

  scope :active, -> { where(active: true) }

  belongs_to :deck
  has_one :game, through: :deck
  has_many :matches, dependent: :nullify

  validates :name, presence: true
  validates :cards, presence: true
  validates :active, uniqueness: { scope: :deck_id, conditions: -> { active } }
  validate :card_total

  private

  def ensure_single_deck_active
    self.class.find_by(deck_id:, active: true)&.update(active: false)
  end

  def card_count
    cards.sum { |card| card['count'] }
  end

  def card_total
    game&.card_count_valid(count: card_count)
  end

end
