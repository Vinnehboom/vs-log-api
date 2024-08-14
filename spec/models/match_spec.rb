require 'rails_helper'

RSpec.describe Match do
  it { is_expected.to belong_to(:deck).optional }
  it { is_expected.to belong_to(:archetype) }
  it { is_expected.to belong_to(:opponent_archetype) }
  it { is_expected.to have_many(:match_games) }
  it { is_expected.to belong_to(:list).optional }
  it { is_expected.to validate_inclusion_of(:result).in_array(%w[W L T ID WW WL LW LL WLW WLL LWW LWL]) }
end
