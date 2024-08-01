require 'rails_helper'

RSpec.describe Deck do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:archetype) }
  it { is_expected.to validate_presence_of(:name) }
end
