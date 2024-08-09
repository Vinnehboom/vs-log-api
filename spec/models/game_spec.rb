require 'rails_helper'

RSpec.describe Game do
  it { is_expected.to have_many(:decks) }
end
