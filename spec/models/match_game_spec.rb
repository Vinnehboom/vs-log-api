require 'rails_helper'

RSpec.describe MatchGame do
  it { is_expected.to belong_to(:match) }
  it { is_expected.to validate_inclusion_of(:result).in_array(%w[W L T ID]) }
end
