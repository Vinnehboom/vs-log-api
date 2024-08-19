require 'rails_helper'

RSpec.describe Card do
  it { is_expected.to validate_presence_of(:set_id) }
  it { is_expected.to validate_presence_of(:set_number) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:count) }

  it { is_expected.to belong_to(:list) }
end
