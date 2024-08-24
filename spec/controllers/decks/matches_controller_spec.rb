require 'rails_helper'

module Decks

  RSpec.describe MatchesController do
    before do
      FirebaseIdToken.test!
      request.headers['HTTP_FIREBASE_ID_TOKEN'] = create_firebase_userid_token(user: firebase_user_id)
    end

    let(:game) { create(:game) }
    let!(:deck) { create(:deck, game:, user_id: firebase_user_id) }

    describe '#index' do
      it 'returns all matches for the deck' do
        deck_matches = create_list(:match, 2, deck:)
        other_deck_matches = create_list(:match, 2)
        get :index, params: { game: game.id, deck_id: deck.id }, format: :json
        expect(assigns(:matches)).to include(*deck_matches)
        expect(assigns(:matches)).not_to include(*other_deck_matches)
      end

      describe 'when expanding the match games' do
        it 'includes all match games' do
          match = create(:match, deck:)
          create(:match_game, match:)
          get :index, params: { game: game.id, deck_id: deck.id, expand: 'match_games' }, format: :json
          expect(response.parsed_body.first['match_games']).to be_present
        end
      end
    end
  end

end
