require 'spec_helper'

module Lists

  RSpec.describe Parser do
    let(:game) { create(:game, id: 'PTCG') }
    let(:parser) { PokemonTcgParser.new }

    describe '#parse' do
      let(:cards) do
        ['3 Arceus VSTAR BRS 123',
         '3 Arceus V BRS 122']
      end

      it 'parses the cards from the given list' do
        parsed_cards = parser.parse(cards:)
        expect(parsed_cards).to be_present
      end

      describe 'the card' do
        subject { parser.parse(cards:).sample }

        it { is_expected.to include(:count) }
        it { is_expected.to include(:name) }
        it { is_expected.to include(:set_id) }
        it { is_expected.to include(:set_number) }

        describe 'the attributes' do
          let(:card) { parser.parse(cards:).first }

          it 'collects the name correctly' do
            expect(card[:name]).to eq('Arceus VSTAR')
          end

          it 'collects the set id' do
            expect(card[:set_id]).to eq('BRS')
          end

          it 'collects the set number' do
            expect(card[:set_number]).to eq('123')
          end

          it 'collects the count' do
            expect(card[:count]).to eq(3)
          end
        end
      end
    end
  end

end
