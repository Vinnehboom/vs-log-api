class Card < ApplicationRecord

  belongs_to :list
  validates :name, presence: true
  validates :set_id, presence: true
  validates :count, presence: true
  validates :set_number, presence: true

end
