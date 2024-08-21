module Lists

  RSpec.describe ParserFactory do
    describe '.call' do
      subject { described_class.call(game:) }

      let(:game) { create(:game) }

      describe 'when the game has an parser' do
        let(:parser_double) { instance_double(Parser) }
        let(:factory_double) { instance_double(described_class) }

        before do
          allow(described_class).to receive(:new).and_return(factory_double)
          allow(factory_double).to receive(:call).and_return(parser_double)
        end

        it { is_expected.to eq(parser_double) }
      end

      describe 'when the game has no parser' do
        it { is_expected.to be_a(Parser) }
      end
    end
  end

end
