class Match < ApplicationRecord

  belongs_to :list, optional: true
  belongs_to :deck, optional: true
  belongs_to :opponent_archetype, class_name: 'Archetype'
  belongs_to :archetype, class_name: 'Archetype'

  def self.results
    %w[W L T ID WW WL LW LL WLW WLL LWW LWL]
  end

  validates :result, presence: true, inclusion: { in: results }

end
