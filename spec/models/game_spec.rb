require 'rails_helper'

RSpec.describe Game do
  it { is_expected.to have_many(:decks) }
  it { is_expected.to have_many(:archetypes) }
  it { is_expected.to validate_presence_of(:name) }
end
