require 'swagger_helper'

RSpec.describe 'decks' do
  before do
    FirebaseIdToken.test!
  end

  describe 'Decks API' do
    let(:game) { create(:game) }
    let(:HTTP_FIREBASE_ID_TOKEN) { create_firebase_userid_token(user: firebase_user_id) }

    path '/{game_id}/decks' do
      let(:decks) { create_list(:deck, 3, game:, user_id: firebase_user_id) }
      let(:game_id) { game.id }

      get "Retrieve all the user's decks" do
        tags 'Decks'
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        response '401', 'unauthorized' do
          let(:HTTP_FIREBASE_ID_TOKEN) { '32113312' }
          run_test!
        end

        response '200', 'Deck found' do
          example 'application/json', :example_key, [{
            game_id: 'PTCG',
            id: '1234-abcd',
            user_id: ' 123d-adsd',
            archetype_id: 9,
            name: 'Psychic Elegance',
            archetype: {
              id: 1,
              identifier: 'gardevoir-ex-sv',
              name: 'Gardevoir ex',
              priority: 10,
              generation: 9,
              game_id: 'PTCG',
              cards: [
                {
                  name: 'Gardevoir ex',
                  count: '2'
                }
              ]
            }
          }]

          run_test!
        end
      end

      post 'add a deck' do
        tags 'Decks'
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        parameter name: :deck, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            active: { type: :boolean },
            archetype_id: { type: :string }
          },
          required: %w[name archetype_id]
        }

        response '201', 'deck created' do
          let(:deck) do
            { deck: build(:deck, archetype_id: create(:archetype).id).attributes }
          end

          run_test!
        end

        response '422', 'invalid request' do
          let(:deck) do
            { deck: build(:deck, name: nil).attributes }
          end

          run_test!
        end
      end
    end

    path '/{game_id}/decks/{id}' do
      let(:deck) { create(:deck, game:, user_id: firebase_user_id) }
      let(:id) { deck.id }
      let(:game_id) { game.id }

      get 'Retrieve a deck' do
        tags 'Decks'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: :game_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'
        response '200', 'Decks found' do
          schema type: :object,
                 properties: {
                   game_id: { type: :string },
                   id: { type: :string },
                   user_id: { type: :string },
                   name: { type: :string },
                   archetype: { type: :object,
                                properties: {
                                  id: { type: :integer },
                                  identifier: { type: :string },
                                  name: { type: :string },
                                  priority: { type: :integer },
                                  generation: { type: :integer },
                                  game_id: { type: :string },
                                  cards: { type: :array }
                                } }
                 },
                 required: %w[id name archetype user_id game_id]

          example 'application/json', :example_key, {
            game_id: 'PTCG',
            id: '1234-abcd',
            user_id: ' 123d-adsd',
            archetype_id: 9,
            name: 'Psychic Elegance',
            archetype: {
              id: 1,
              identifier: 'gardevoir-ex-sv',
              name: 'Gardevoir ex',
              priority: 10,
              generation: 9,
              game_id: 'PTCG',
              cards: [
                {
                  name: 'Gardevoir ex',
                  count: '2'
                }
              ]
            }
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

      patch 'update a deck' do
        tags 'Decks'
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        parameter name: :deck, getter: :deck_body, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            active: { type: :boolean },
            archetype_id: { type: :string }
          },
          required: %w[name archetype_id]
        }

        response '200', 'deck updated' do
          let(:deck_body) do
            deck.name = 'new name'
            deck.attributes
          end

          run_test!
        end
      end

      delete 'delete a deck' do
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        response '204', 'deck deleted' do
          let(:deck) { create(:deck, game:, user_id: firebase_user_id) }
          let(:id) { deck.id }

          run_test!
        end
      end
    end
  end
end
