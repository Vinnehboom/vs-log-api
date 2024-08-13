class List < ApplicationRecord

  belongs_to :deck
  validates :name, presence: true
  validates :cards, presence: true
  has_many :match_records, dependent: :nullify

end
