require 'swagger_helper'

RSpec.describe 'archetypes' do
  before do
    FirebaseIdToken.test!
  end

  describe 'Archetypes API' do
    let(:game) { create(:game) }
    let(:HTTP_FIREBASE_ID_TOKEN) { create_firebase_userid_token(user: firebase_user_id) }

    path '/{game_id}/archetypes' do
      let(:archetypes) { create_list(:archetype, 3, game:) }
      let(:game_id) { game.id }

      get "Retrieve all the game's archetypes" do
        tags 'Archetypes'
        consumes 'application/json'
        description 'Archetypes are shown by generation descending'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'
        parameter name: :identifier, type: :string, in: :query, required: false,
                  description: 'Find archetypes whose identifier contains the query string'
        parameter name: :name, type: :string, in: :query, required: false,
                  description: 'Find archetypes whose name contains the query string'

        response '401', 'unauthorized' do
          let(:HTTP_FIREBASE_ID_TOKEN) { '32113312' }
          run_test!
        end

        response '200', 'Archetypes found' do
          example 'application/json', :base, [
            {
              game_id: 'PTCG',
              id: 1,
              identifier: 'gardevoir-ex-sv',
              name: 'Gardevoir ex',
              priority: 10,
              generation: 9,
              cards: [
                {
                  name: 'Gardevoir ex',
                  count: '2'
                }
              ],
              icons: [
                {
                  'gardevoir-ex' => 'https://icons.com/gardevoir-ex'
                }
              ]
            },
            {
              game_id: 'PTCG',
              id: 1,
              identifier: 'charizard-ex',
              name: 'Charizard ex',
              priority: 10,
              generation: 9,
              cards: [
                {
                  name: 'Charizard ex',
                  count: '3'
                }
              ],
              icons: [
                {
                  'charizard-ex' => 'https://icons.com/charizard-ex'
                }
              ]
            }
          ]

          example 'application/json', :filter_charizard, [
            {
              game_id: 'PTCG',
              id: 1,
              identifier: 'charizard-ex',
              name: 'Charizard ex',
              priority: 10,
              generation: 9,
              cards: [
                {
                  name: 'Charizard ex',
                  count: '3'
                }
              ],
              icons: [
                {
                  'charizard-ex' => 'https://icons.com/charizard-ex'
                }
              ]
            }
          ]

          run_test!
        end
      end
    end

    path '/{game_id}/archetypes/{id}' do
      let(:archetype) { create(:archetype, game:) }
      let(:id) { archetype.id }
      let(:game_id) { game.id }

      get 'Retrieve an archetype' do
        tags 'Archetypes'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: :game_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        response '200', 'archetype found' do
          schema type: :object,
                 properties: {
                   game_id: { type: :string },
                   id: { type: :integer },
                   identifier: { type: :string },
                   name: { type: :string },
                   priority: { type: :integer },
                   generation: { type: :integer },
                   cards: { type: :array },
                   icons: { type: :array }
                 },
                 required: %w[id game_id name identifier icons cards priority generation]

          example 'application/json', :example_key, {
            game_id: 'PTCG',
            id: 1,
            identifier: 'gardevoir-ex-sv',
            name: 'Gardevoir ex',
            priority: 10,
            generation: 9,
            cards: [
              {
                name: 'Gardevoir ex',
                count: '2'
              }
            ]
          }

          run_test!
        end

        response '401', 'unauthorized' do
          let(:HTTP_FIREBASE_ID_TOKEN) { '32113312' }
          run_test!
        end

        response '404', 'Archetype not found' do
          let(:id) { 'invalid' }

          run_test!
        end
      end
    end
  end
end
