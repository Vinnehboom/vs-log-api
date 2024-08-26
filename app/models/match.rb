class Match < ApplicationRecord

  belongs_to :list, optional: true
  belongs_to :deck, optional: true
  belongs_to :opponent_archetype, class_name: 'Archetype'
  belongs_to :archetype, class_name: 'Archetype'
  has_many :match_games, dependent: :destroy

  accepts_nested_attributes_for :match_games

  def self.results
    %w[W L T ID WW WL LW LL WLW WLL LWW LWL]
  end

  validates :result, presence: true, inclusion: { in: results }
  validates :match_games, presence: true
  validates :coinflip_won, inclusion: { in: [true, false] }, if: :bo3
  validate :match_count

  private

  def match_count
    max = bo3 ? 3 : 1
    return unless match_games.length > max

    errors.add(:match_games, :limit_exceeded)
  end

end
