require 'rails_helper'

RSpec.describe Match do
  it { is_expected.to belong_to(:deck).optional }
  it { is_expected.to belong_to(:archetype) }
  it { is_expected.to belong_to(:opponent_archetype) }
  it { is_expected.to have_many(:match_games) }
  it { is_expected.to belong_to(:list).optional }

  describe '#match_games presence' do
    describe 'when the context is during api creation' do
      describe 'when the match has no games' do
        subject do
          match = build(:match)
          match.match_games = []
          match
        end

        it { is_expected.not_to be_valid(:api_create) }
      end

      describe 'when the match has games' do
        subject do
          match = build(:match)
          match.match_games = build_list(:match_game, 1)
          match
        end

        it { is_expected.to be_valid(:api_create) }
      end
    end
  end

  describe 'match games count validation' do
    describe 'when the match is bo3' do
      it 'does not allow more than 3 games added' do
        match = build(:match)
        match.match_games = build_list(:match_game, 4)
        match.bo3 = true
        match.save
        expect(match.errors[:match_games]).to eq(['Too many games added to the match'])
      end
    end

    describe 'when the match is not bo3' do
      it 'does not allow more than 1 game added' do
        match = build(:match)
        match.bo3 = false
        match.match_games = build_list(:match_game, 2)

        match.save
        expect(match.errors[:match_games]).to eq(['Too many games added to the match'])
      end
    end
  end
end
