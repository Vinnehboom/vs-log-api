require 'rails_helper'

RSpec.describe List do
  it { is_expected.to belong_to(:deck) }
  it { is_expected.to validate_presence_of(:cards) }
  it { is_expected.to validate_presence_of(:name) }
end
