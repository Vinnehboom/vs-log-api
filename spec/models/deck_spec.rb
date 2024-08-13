require 'rails_helper'

RSpec.describe Deck do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:lists) }
  it { is_expected.to belong_to(:game) }
  it { is_expected.to belong_to(:archetype) }
end
