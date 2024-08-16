require 'rails_helper'

RSpec.describe Game do
  it { is_expected.to have_many(:decks) }
  it { is_expected.to have_many(:archetypes) }
  it { is_expected.to validate_presence_of(:name) }

  describe '#card_count_valid(count)' do
    subject { game.card_count_valid(count:) }

    describe 'when the game requires an exact card count' do
      let(:game) { create(:game, exact_count: true, deck_card_count: 60) }

      describe 'when the count is exact' do
        let(:count) { 60 }

        it { is_expected.to be_truthy }
      end

      describe 'when the count is not exact' do
        let(:count) { (1..59).to_a.sample }

        it { is_expected.to be_falsy }
      end
    end

    describe 'when the game requires an minimum card count' do
      let(:game) { create(:game, exact_count: false, deck_card_count: 60) }

      describe 'when the count is equal to the minimum' do
        let(:count) { 60 }

        it { is_expected.to be_truthy }
      end

      describe 'when the count is higher than the minimum' do
        let(:count) { rand(60..69) }

        it { is_expected.to be_truthy }
      end

      describe 'when the count is lower than the minimum' do
        let(:count) { rand(50..59) }

        it { is_expected.to be_falsy }
      end
    end
  end
end
