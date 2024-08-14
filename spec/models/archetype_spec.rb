require 'rails_helper'

RSpec.describe Archetype do
  it { is_expected.to belong_to(:game) }
  it { is_expected.to have_many(:decks) }
  it { is_expected.to have_many(:matches) }
  it { is_expected.to have_many(:opponent_matches) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:identifier) }

  describe 'unique identifier' do
    subject { build(:archetype, identifier: 'test') }

    it { is_expected.to validate_uniqueness_of(:identifier) }
  end
end
