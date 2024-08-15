require 'rails_helper'

RSpec.describe Deck do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:lists) }
  it { is_expected.to have_many(:matches) }
  it { is_expected.to belong_to(:game) }
  it { is_expected.to belong_to(:archetype) }

  describe '#active' do
    describe 'when updating a users active deck' do
      let(:user_id) { 'abcd-efgh' }
      let(:decks) { create_list(:deck, 3, user_id:, active: false) }

      it 'sets the deck as active' do
        deck = decks.sample
        deck.update(active: true)
        expect(deck.reload).to be_active
      end

      describe 'when the user had a previous active deck' do
        let!(:active_deck) do
          deck = decks.first
          deck.update(active: true)
          deck
        end

        it 'sets the previous deck as inactive' do
          deck = decks.second
          deck.update(active: true)
          expect(active_deck.reload).not_to be_active
        end
      end
    end
  end
end
