require 'swagger_helper'

RSpec.describe 'decks/lists' do
  before do
    FirebaseIdToken.test!
  end

  describe 'Lists API' do
    let(:game) { create(:game) }
    let(:HTTP_FIREBASE_ID_TOKEN) { create_firebase_userid_token(user: firebase_user_id) }
    let(:deck) { create(:deck, game:, user_id: firebase_user_id) }

    path '/{game_id}/decks/{deck_id}/lists' do
      let(:lists) { create_list(:list, 3, deck:) }
      let(:game_id) { game.id }
      let(:deck_id) { deck.id }

      get "Retrieve all the deck's lists" do
        tags 'Lists'
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :deck_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string

        response '401', 'unauthorized' do
          let(:HTTP_FIREBASE_ID_TOKEN) { '32113312' }
          run_test!
        end

        response '200', 'Lists found' do
          example 'application/json', :example_key, [{
            deck_id: '1234',
            id: '4567',
            user_id: 'qweqejqe1234',
            name: 'Psychic Elegance',
            cards: [{ 'card' => { 'apiSetId' => 'swsh9',
                                  'name' => 'Arceus VSTAR', 'setId' => 'BRS', 'setNumber' => '123' }, 'count' => 3 },
                    {
                      'card' => { 'apiSetId' => 'swsh9',
                                  'name' => 'Arceus V', 'setId' => 'BRS', 'setNumber' => '122' }, 'count' => 4
                    }],
            active: false
          }]

          run_test!
        end
      end
    end

    path '/{game_id}/decks/{deck_id}/lists/{id}' do
      let(:list) { create(:list, deck:) }
      let(:deck_id) { deck.id }
      let(:id) { list.id }
      let(:game_id) { game.id }

      get 'Retrieve a list' do
        tags 'Lists'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: :game_id, in: :path, type: :string
        parameter name: :deck_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string

        response '200', 'List found' do
          schema type: :object,
                 properties: {
                   deck_id: { type: :string },
                   id: { type: :string },
                   cards: { type: :json },
                   name: { type: :string },
                   active: { type: :boolean }
                 },
                 required: %w[id name deck_id cards]

          example 'application/json', :example_key, {
            deck_id: '1234',
            id: '4567',
            user_id: 'qweqejqe1234',
            name: 'Psychic Elegance',
            cards: [{ 'card' => { 'apiSetId' => 'swsh9',
                                  'name' => 'Arceus VSTAR', 'setId' => 'BRS', 'setNumber' => '123' }, 'count' => 3 },
                    {
                      'card' => { 'apiSetId' => 'swsh9', 'name' => 'Arceus V', 'setId' => 'BRS',
                                  'setNumber' => '122' }, 'count' => 4
                    }],
            active: false
          }

          run_test!
        end

        response '401', 'unauthorized' do
          let(:HTTP_FIREBASE_ID_TOKEN) { '32113312' }
          run_test!
        end

        response '404', 'Deck not found' do
          let(:id) { 'invalid' }

          run_test!
        end
      end
    end
  end
end
