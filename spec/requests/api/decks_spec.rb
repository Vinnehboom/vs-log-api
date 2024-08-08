require 'swagger_helper'

RSpec.describe 'api/decks' do
  describe 'Decks API' do
    path '/decks' do
      get 'Retrieve all blogs' do
        tags 'Decks'
        consumes 'application/json'

        response '200', 'Deck found' do
          example 'application/json', :example_key, [{
            game_id: 'PTCG',
            id: '1234-abcd',
            user_id: ' 123d-adsd',
            archetype: { identifier: 'gardevoir-ex' },
            name: 'Psychic Elegance'
          }]

          let(:decks) { create_list(:deck, 3) }
          run_test!
        end
      end

      path '/decks/{id}' do
        get 'Retrieve a blog' do
          let(:deck) { create(:deck) }
          tags 'Decks'
          consumes 'application/json'
          parameter name: :id, in: :path, type: :string

          response '200', 'Decks found' do
            schema type: :object,
                   properties: {
                     game_id: { type: :string },
                     id: { type: :string },
                     user_id: { type: :string },
                     name: { type: :string },
                     archetype: { type: :json }
                   },
                   required: %w[id name archetype user_id]

            example 'application/json', :example_key, {
              game_id: 'PTCG',
              id: '1234-abcd',
              user_id: ' 123d-adsd',
              archetype: { identifier: 'gardevoir-ex' },
              name: 'Psychic Elegance'
            }

            let(:id) { deck.id }
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
end
