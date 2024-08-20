require 'rails_helper'

RSpec.describe Card do
  it { is_expected.to validate_presence_of(:set_id) }
  it { is_expected.to validate_presence_of(:set_number) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:count) }

  it { is_expected.to belong_to(:list) }

  describe '#image' do
    let(:image_double) { instance_double(Cards::Image) }
    let(:card) { create(:card) }
    let(:url) { 'https://image.com' }

    before do
      allow(Cards::ImageFactory).to receive(:call).and_return(image_double)
      allow(image_double).to receive(:url).and_return(url)
    end

    it 'returns an image of the card' do
      expect(card.image).to eq(url)
    end
  end
end
