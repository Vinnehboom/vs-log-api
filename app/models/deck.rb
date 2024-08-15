class Deck < ApplicationRecord

  before_validation :ensure_single_user_active, if: :active

  scope :active, -> { where(active: true) }

  validates :user_id, presence: true
  validates :name, presence: true
  validates :active, uniqueness: { scope: :user_id, conditions: -> { active } }

  has_many :lists, dependent: :destroy
  has_many :matches, dependent: :nullify
  belongs_to :game
  belongs_to :archetype

  private

  def ensure_single_user_active
    self.class.find_by(user_id:, active: true)&.update(active: false)
  end

end
