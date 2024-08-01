class Deck < ApplicationRecord

  validates :user_id, presence: true
  validates :name, presence: true
  validates :archetype, presence: true

end
