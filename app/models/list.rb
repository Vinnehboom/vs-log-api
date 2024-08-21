class List < ApplicationRecord

  before_validation :ensure_single_deck_active, if: :active

  scope :active, -> { where(active: true) }

  belongs_to :deck
  has_many :matches, dependent: :nullify
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :active, uniqueness: { scope: :deck_id, conditions: -> { active } }
  validate :card_total
  accepts_nested_attributes_for :cards

  def game
    deck&.game
  end

  private

  def ensure_single_deck_active
    self.class.find_by(deck_id:, active: true)&.update(active: false)
  end

  def card_count
    cards.sum(&:count)
  end

  def card_total
    return if game&.card_count_valid(count: card_count)

    errors.add(:cards, :invalid_card_count)
  end

end
