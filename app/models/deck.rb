class Deck < ApplicationRecord

  validates :user_id, presence: true
  validates :name, presence: true

  has_many :lists, dependent: :destroy
  belongs_to :game
  belongs_to :archetype

end
