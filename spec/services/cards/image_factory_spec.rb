module Cards

  RSpec.describe ImageFactory do
    describe '.call' do
      subject { described_class.call(game:, card:) }

      let(:game) { create(:game) }
      let(:card) { create(:card) }

      describe 'when the game has an image generator' do
        let(:image_double) { instance_double(Image) }
        let(:factory_double) { instance_double(described_class) }

        before do
          allow(described_class).to receive(:new).and_return(factory_double)
          allow(factory_double).to receive(:call).and_return(image_double)
        end

        it { is_expected.to eq(image_double) }
      end

      describe 'when the game has no image generator' do
        it { is_expected.to be_a(Image) }
      end
    end
  end

end
