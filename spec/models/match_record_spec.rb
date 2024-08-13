require 'rails_helper'

RSpec.describe MatchRecord do
  it { is_expected.to belong_to(:deck) }
  it { is_expected.to belong_to(:archetype) }
  it { is_expected.to belong_to(:opponent_archetype) }
  it { is_expected.to belong_to(:list) }
end
