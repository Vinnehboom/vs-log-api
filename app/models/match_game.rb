class MatchGame < ApplicationRecord

  belongs_to :match
  belongs_to :list, optional: true
  validates :result, presence: true, inclusion: { in: %w[W L T ID] }
  validates :started, inclusion: { in: [true, false] }

end
