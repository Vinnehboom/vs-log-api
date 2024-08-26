require 'rails_helper'

RSpec.describe Match do
  it { is_expected.to belong_to(:deck).optional }
  it { is_expected.to belong_to(:archetype) }
  it { is_expected.to belong_to(:opponent_archetype) }
  it { is_expected.to have_many(:match_games) }
  it { is_expected.to belong_to(:list).optional }
  it { is_expected.to validate_inclusion_of(:result).in_array(%w[W L T ID WW WL LW LL WLW WLL LWW LWL]) }
  it { is_expected.to validate_presence_of(:match_games) }

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
