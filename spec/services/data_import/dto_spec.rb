require 'spec_helper'

module DataImport

  RSpec.describe Dto do
    let(:example_class) { Deck }
    let(:example_dto_class) { DeckDto }
    let(:example_instance) { build(:deck) }
    let(:example_dto_instance) { example_dto_class.new(object: example_instance.attributes) }

    describe '#update_instance' do
      describe 'when the record does not exist yet' do
        it 'creates the record with the given data' do
          expect { example_dto_instance.update_instance }.to change(example_class, :count).by(1)
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
          expect(example_class.find(example_instance.id).name).not_to eq('old name')
        end
      end
    end
  end

end
