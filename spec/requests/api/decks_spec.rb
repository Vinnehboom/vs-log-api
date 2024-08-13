require 'swagger_helper'

RSpec.describe 'api/decks' do
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
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string

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
            name: 'Psychic Elegance'
          }]

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
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string

        response '200', 'Decks found' do
          schema type: :object,
                 properties: {
                   game_id: { type: :string },
                   id: { type: :string },
                   user_id: { type: :string },
                   name: { type: :string },
                   archetype_id: { type: :integer }
                 },
                 required: %w[id name archetype_id user_id]

          example 'application/json', :example_key, {
            game_id: 'PTCG',
            id: '1234-abcd',
            user_id: ' 123d-adsd',
            archetype_id: 9,
            name: 'Psychic Elegance'
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
