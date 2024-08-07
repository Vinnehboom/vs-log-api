class Deck < ApplicationRecord

  validates :user_id, presence: true
  validates :name, presence: true
  validates :archetype, presence: true

  has_many :lists, dependent: :destroy

end
