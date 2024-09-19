require 'rails_helper'

RSpec.describe MatchesController do
  before do
    FirebaseIdToken.test!
    request.headers['HTTP_FIREBASE_ID_TOKEN'] = create_firebase_userid_token(user: firebase_user_id)
  end

  let(:game) { create(:game) }
  let(:deck) { create(:deck, user_id: firebase_user_id) }

  describe '#index' do
    it 'returns all matches for the user' do
      user_matches = create_list(:match, 4, deck: create(:deck, user_id: firebase_user_id))
      get :index, params: { game: game.id }, format: :json
      expect(assigns(:matches)).to include(*user_matches)
    end

    describe 'when expanding the match games' do
      it 'includes all match games' do
        match = create(:match, deck:)
        create(:match_game, match:)
        get :index, params: { game: game.id, expand: 'match_games' }, format: :json
        expect(response.parsed_body.first['match_games']).to be_present
      end
    end

    describe 'when filtering the results' do
      describe 'when filtering for list' do
        it 'only returns matches for the given lists' do
          archetype1 = create(:archetype, game:)
          archetype2 = create(:archetype, game:)
          archetype1_matches = create_list(:match, 2, archetype: archetype1, deck:)
          archetype2_matches = create_list(:match, 2, archetype: archetype2, deck:)
          other_matches = create_list(:match, 2, deck:)
          get :index, params: {
            game: game.id,
            archetype_id: "#{archetype1.id},#{archetype2.id}"
          }, format: :json
          expect(assigns(:matches)).to include(*archetype1_matches, *archetype2_matches)
          expect(assigns(:matches)).not_to include(*other_matches)
        end
      end

      describe 'when filtering for opponent archetype' do
        it 'only returns matches for the given lists' do
          archetype = create(:archetype, game:)
          archetype2 = create(:archetype, game:)
          archetype1_matches = create_list(:match, 2, opponent_archetype: archetype, deck:)
          archetype2_matches = create_list(:match, 2, opponent_archetype: archetype2, deck:)
          other_matches = create_list(:match, 2, deck:)
          get :index, params: {
            game: game.id,
            opponent_archetype_id: "#{archetype.id},#{archetype2.id}"
          }, format: :json
          expect(assigns(:matches)).to include(*archetype1_matches, *archetype2_matches)
          expect(assigns(:matches)).not_to include(*other_matches)
        end
      end
    end
  end
end
