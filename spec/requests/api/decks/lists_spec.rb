require 'swagger_helper'

RSpec.describe 'decks/lists' do
  before do
    FirebaseIdToken.test!
  end

  describe 'Lists API' do
    let(:game) { create(:game, id: 'PTCG') }
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
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'
        parameter name: :active, in: :query, type: :boolean, required: false, description: 'filter for active lists'

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
            list_cards: [{ 'set_id' => 'BRS',
                           'name' => 'Arceus VSTAR',
                           'set_number' => '123',
                           'count' => 3,
                           'image' => 'https://images.pokemontcg.io/swsh9/123.png' },
                         { 'set_id' => 'BRS',
                           'name' => 'Arceus V',
                           'set_number' => '122',
                           'count' => 4,
                           'image' => 'https://images.pokemontcg.io/swsh9/122.png' }],
            active: false
          }]

          run_test!
        end
      end

      post 'add a list to the deck' do
        tags 'Lists'
        consumes 'application/json'
        description 'Add a list to the target deck.
The cards argument of the body takes a split list of a usual export from your game client or online resource.
Invalid card strings will be ignored automatically.'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :deck_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        parameter name: :list, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            active: { type: :boolean },
            cards: {
              type: :array, items: {
                type: :string
              }, example: [
                '3 Arceus VSTAR BRS 123',
                '3 Arceus V BRS 122'
              ]
            }
          },
          required: %w[name cards]
        }

        response '201', 'list created' do
          let(:list) do
            { list: build(:list, deck:).attributes.merge(cards: [
                                                           '3 Arceus VSTAR BRS 123',
                                                           '3 Arceus V BRS 122',
                                                           '54 Fire Energy Energy 5'
                                                         ]) }
          end

          run_test!
        end

        response '422', 'invalid request' do
          let(:list) do
            { list: build(:list, deck:).attributes.merge(cards: [
                                                           '3 Arceus VSTAR BRS 123',
                                                           '3 Arceus V BRS 122'
                                                         ]) }
          end

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
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        response '200', 'List found' do
          schema type: :object,
                 properties: {
                   deck_id: { type: :string },
                   id: { type: :string },
                   list_cards: { type: :array, items: {
                                                 type: :object,
                                                 properties: {
                                                   set_id: { type: :string },
                                                   name: { type: :string },
                                                   set_number: { type: :string },
                                                   count: { type: :integer },
                                                   image: { type: :string }
                                                 }
                                               },
                                 name: { type: :string },
                                 active: { type: :boolean } },
                   required: %w[id name deck_id list_cards]
                 }

          example 'application/json', :example_key, {
            deck_id: '1234',
            id: '4567',
            user_id: 'qweqejqe1234',
            name: 'Psychic Elegance',
            list_cards: [{ 'set_id' => 'BRS',
                           'name' => 'Arceus VSTAR',
                           'set_number' => '123',
                           'count' => 3,
                           'image' => 'https://images.pokemontcg.io/swsh9/123.png' },
                         { 'set_id' => 'BRS',
                           'name' => 'Arceus V',
                           'set_number' => '122',
                           'count' => 4,
                           'image' => 'https://images.pokemontcg.io/swsh9/122.png' }],
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

      patch "update a deck's list" do
        tags 'Lists'
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :deck_id, in: :path, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        parameter name: :list, getter: :list_body, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            active: { type: :boolean }
          },
          required: ['name']
        }

        response '200', 'list updated' do
          let(:list_body) do
            list.name = 'new name'
            list.attributes
          end
          let(:id) { list.id }

          run_test!
        end
      end

      delete "delete a deck's list" do
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :deck_id, in: :path, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        response '204', 'list deleted' do
          let(:id) { list.id }

          run_test!
        end
      end
    end
  end
end
