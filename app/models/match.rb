class Match < ApplicationRecord

  belongs_to :list, optional: true
  belongs_to :deck, optional: true
  belongs_to :opponent_archetype, class_name: 'Archetype'
  belongs_to :archetype, class_name: 'Archetype'
  has_many :match_games, dependent: :destroy

  accepts_nested_attributes_for :match_games

  validates :match_games, presence: true, on: :api_create
  validates :coinflip_won, inclusion: { in: [true, false] }, if: :bo3
  validate :match_count

  def result
    match_games.pluck(:result).join
  end

  private

  def match_count
    max = bo3 ? 3 : 1
    return unless match_games.length > max

    errors.add(:match_games, :limit_exceeded)
  end

end
