require 'spec_helper'

module DataImport

  RSpec.describe Dto do
    let(:example_class) { Deck }
    let(:example_dto_class) { DeckDto }
    let(:game) { create(:game) }
    let(:archetype) { create(:archetype, game:) }
    let(:example_instance) { build(:deck) }
    let(:object) do
      {
        'userId' => example_instance.user_id,
        'id' => example_instance.id,
        'name' => example_instance.name,
        'archetype' => { 'identifier' => archetype.identifier }
      }
    end
    let(:example_dto_instance) { example_dto_class.new(object:, game:) }

    describe '#update_instance' do
      describe 'when the record does not exist yet' do
        it 'creates the record with the given data' do
          expect { example_dto_instance.update_instance }.to change(example_class, :count).by(1)
        end

        describe 'when the record belongs to a game' do
          it 'adds the relationship to the passed game' do
            example_dto_instance.update_instance
            expect(Deck.last.game_id).to eq(game.id)
          end
        end

        describe 'when the record does not belong to a game' do
          let(:example_class) { List }
          let(:example_dto_class) { ListDto }
          let(:example_instance) { build(:list, deck: create(:deck)) }
          let(:object) do
            object = example_instance.attributes.transform_keys { |key| key.camelize(:lower).split('_').join }
            object = object.merge('cards' => [{ 'card' => { 'name' => 'test', 'setId' => 'PAF', 'setNumber' => '1' },
                                                'count' => 60 }])
            object
          end

          it 'does not add the relationship to the passed game' do
            example_dto_instance.update_instance
            expect(List.last).not_to respond_to(:game_id)
          end
        end
      end

      describe 'when the deck exists' do
        before do
          example_instance.save!
          example_instance.update!(name: 'old name')
          example_instance.name = 'new name'
        end

        it 'does not create a new record' do
          expect { example_dto_instance.update_instance }.not_to change(example_class, :count)
        end

        it 'updates the record' do
          example_dto_instance.update_instance
          expect(example_class.find(example_instance['id']).name).not_to eq('old name')
        end
      end
    end
  end

end
