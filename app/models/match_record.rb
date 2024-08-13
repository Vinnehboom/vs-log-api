class MatchRecord < ApplicationRecord

  belongs_to :list
  belongs_to :deck
  belongs_to :opponent_archetype, class_name: 'Archetype'
  belongs_to :archetype, class_name: 'Archetype'

  enum result: { W: 0, L: 1, T: 2, ID: 3, WW: 4, WL: 5, LW: 6, LL: 7, WLW: 8, WLL: 9, LWW: 10, LWL: 11 }

end
