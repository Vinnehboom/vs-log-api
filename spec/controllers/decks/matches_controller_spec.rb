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

    describe '#show' do
      let(:match) { create(:match, deck:) }

      it 'returns the match' do
        get :show, params: { game: game.id, deck_id: deck.id, id: match.id }, format: :json
        expect(assigns(:match)).to eq(match)
      end

      it 'includes all match games' do
        create(:match_game, match:)
        get :show, params: { game: game.id, deck_id: deck.id, id: match.id }, format: :json
        expect(response.parsed_body['match_games']).to be_present
      end
    end

    describe '#create' do
      describe 'when the match is valid' do
        let(:params) do
          {
            match: {
              deck_id: deck.id,
              archetype_id: create(:archetype, game:).id,
              opponent_archetype_id: create(:archetype, game:).id,
              bo3: false,
              remarks: 'test',
              result: 'W',
              match_games_attributes: [
                {
                  started: false,
                  result: 'W'
                }
              ]
            }
          }
        end

        it 'creates the match' do
          expect do
            post :create, params: params.merge({ game: game.id, deck_id: deck.id }), format: :json
          end.to change(deck.matches, :count).by(1)
        end

        it 'creates the games' do
          expect do
            post :create, params: params.merge({ game: game.id, deck_id: deck.id }), format: :json
          end.to change(MatchGame, :count).by(1)
        end
      end

      describe 'when the match is invalid' do
        let(:params) do
          {
            match: {
              deck_id: deck.id,
              archetype_id: create(:archetype, game:).id,
              bo3: false,
              remarks: 'test',
              result: 'W',
              match_games_attributes: []
            }
          }
        end

        it 'does not create the match' do
          expect do
            post :create, params: params.merge({ game: game.id, deck_id: deck.id }), format: :json
          end.not_to change(deck.matches, :count)
        end

        it 'informs the user of the errors' do
          post :create, params: params.merge({ game: game.id, deck_id: deck.id }), format: :json
          expect(response.parsed_body['opponent_archetype']).to be_present
          expect(response.parsed_body['match_games']).to be_present
        end
      end
    end

    describe '#update' do
      let(:match) { create(:match, deck:) }

      describe 'when the update is valid' do
        let(:params) do
          {
            match: {
              remarks: 'new remarks'
            }
          }
        end

        it 'updates the match' do
          patch :update, params: params.merge({ game: game.id, deck_id: deck.id, id: match.id }), format: :json
          expect(response.parsed_body['remarks']).to eq('new remarks')
        end
      end

      describe 'when the update is invalid' do
        let(:params) do
          {
            match: {
              opponent_archetype_id: 12_312_312_123_213
            }
          }
        end

        it 'informs the user of the errors' do
          patch :update, params: params.merge({ game: game.id, deck_id: deck.id, id: match.id }), format: :json
          expect(response.parsed_body['opponent_archetype']).to be_present
        end
      end
    end
  end

end
