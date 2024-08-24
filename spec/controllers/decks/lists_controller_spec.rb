require 'rails_helper'

module Decks

  RSpec.describe ListsController do
    before do
      FirebaseIdToken.test!
      request.headers['HTTP_FIREBASE_ID_TOKEN'] = create_firebase_userid_token(user: firebase_user_id)
    end

    let(:game) { create(:game, id: 'PTCG') }
    let!(:deck) { create(:deck, game:, user_id: firebase_user_id) }

    describe '#index' do
      it 'returns all lists for the deck' do
        deck_lists = create_list(:list, 2, deck:)
        other_deck_lists = create_list(:list, 2)
        get :index, params: { game: game.id, deck_id: deck.id }, format: :json
        expect(assigns(:lists)).to include(*deck_lists)
        expect(assigns(:lists)).not_to include(*other_deck_lists)
      end

      it 'does not include the lists cards' do
        create(:list, deck:)
        get :index, params: { game: game.id, deck_id: deck.id }, format: :json
        expect(response.parsed_body.first['cards']).not_to be_present
      end

      describe 'when expanding the cards' do
        it 'includes all list cards' do
          create(:list, deck:)
          get :index, params: { game: game.id, deck_id: deck.id, expand: 'cards' }, format: :json
          expect(response.parsed_body.first['cards']).to be_present
        end
      end
    end

    describe '#show' do
      it 'returns the list' do
        list = create(:list, deck:)
        get :show, params: { game: game.id, deck_id: deck.id, id: list.id }, format: :json
        expect(assigns(:list)).to eq(list)
      end

      it 'includes the lists cards' do
        list = create(:list, deck:)
        get :show, params: { game: game.id, deck_id: deck.id, id: list.id }, format: :json
        expect(response.parsed_body['cards']).to be_present
      end
    end
  end

end
