class Card < ApplicationRecord

  belongs_to :list
  validates :name, presence: true
  validates :set_id, presence: true
  validates :count, presence: true
  validates :set_number, presence: true

  def image
    Cards::ImageFactory.call(card: self, game:).url
  end

  delegate :game, to: :list

end
