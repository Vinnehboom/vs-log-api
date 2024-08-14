class Deck < ApplicationRecord

  validates :user_id, presence: true
  validates :name, presence: true

  has_many :lists, dependent: :destroy
  has_many :matches, dependent: :nullify
  belongs_to :game
  belongs_to :archetype

end
