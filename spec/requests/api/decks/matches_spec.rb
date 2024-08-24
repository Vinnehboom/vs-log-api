require 'swagger_helper'

RSpec.describe 'decks/matches' do
  before do
    FirebaseIdToken.test!
  end

  describe 'Matches API' do
    let(:game) { create(:game, id: 'PTCG') }
    let(:HTTP_FIREBASE_ID_TOKEN) { create_firebase_userid_token(user: firebase_user_id) }
    let(:deck) { create(:deck, game:, user_id: firebase_user_id) }

    path '/{game_id}/decks/{deck_id}/matches' do
      let(:matches) { create_match(:match, 3, deck:) }
      let(:game_id) { game.id }
      let(:deck_id) { deck.id }

      get "Retrieve all the deck's matches" do
        tags 'Matches'
        consumes 'application/json'
        parameter name: :game_id, in: :path, type: :string
        parameter name: :deck_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'
        parameter name: :expand, in: :query, type: :string, required: false,
                  description: 'Allow for expansion of relationships. e.g.: ?expand=match_games'

        response '401', 'unauthorized' do
          let(:HTTP_FIREBASE_ID_TOKEN) { '32113312' }
          run_test!
        end

        response '200', 'Matches found' do
          example 'application/json', :base, [{
                                                id: 'ffff5d43-9173-4504-a576-4e50d9d98ba4',
                                                list_id: '389b987f-0633-4fb8-b834-619e57f6f097',
                                                deck_id: 'a22512c5-27db-49fc-b1fb-9d029720e3a2',
                                                opponent_archetype: {
                                                  game_id: 'PTCG',
                                                  id: 1,
                                                  identifier: 'gardevoir-ex-sv',
                                                  name: 'Gardevoir ex',
                                                  generation: 9,
                                                  cards: [
                                                    {
                                                      name: 'Gardevoir ex',
                                                      count: '2'
                                                    }
                                                  ]
                                                },
                                                archetype: {
                                                  game_id: 'PTCG',
                                                  id: 1,
                                                  identifier: 'gardevoir-ex-sv',
                                                  name: 'Gardevoir ex',
                                                  generation: 9,
                                                  cards: [
                                                    {
                                                      name: 'Gardevoir ex',
                                                      count: '2'
                                                    }
                                                  ]
                                                },
                                                bo3: false,
                                                coinflip_won: nil,
                                                remarks: '',
                                                result: 'L',
                                                created_at: DateTime.now,
                                                updated_at: DateTime.now
                                              }]

          example 'application/json', :expanded_matches, [{
                                                            id: 'ffff5d43-9173-4504-a576-4e50d9d98ba4',
                                                            list_id: '389b987f-0633-4fb8-b834-619e57f6f097',
                                                            deck_id: 'a22512c5-27db-49fc-b1fb-9d029720e3a2',
                                                            bo3: false,
                                                            coinflip_won: nil,
                                                            remarks: '',
                                                            result: 'L',
                                                            opponent_archetype: {
                                                              game_id: 'PTCG',
                                                              id: 1,
                                                              identifier: 'gardevoir-ex-sv',
                                                              name: 'Gardevoir ex',
                                                              generation: 9,
                                                              cards: [
                                                                {
                                                                  name: 'Gardevoir ex',
                                                                  count: '2'
                                                                }
                                                              ]
                                                            },
                                                            archetype: {
                                                              game_id: 'PTCG',
                                                              id: 1,
                                                              identifier: 'gardevoir-ex-sv',
                                                              name: 'Gardevoir ex',
                                                              generation: 9,
                                                              cards: [
                                                                {
                                                                  name: 'Gardevoir ex',
                                                                  count: '2'
                                                                }
                                                              ]
                                                            },
                                                            match_games: [{
                                                                            id: 'ffff5d43-9173-4504-a576-4e50d9d98ba4',
                                                                            match_id: '0079aea2-c836-4d3f-9ea1-1063e4beae2f',
                                                                            result: 'W',
                                                                            started: true
                                                                          }],
                                                            created_at: DateTime.now,
                                                            updated_at: DateTime.now
                                                          }]

          run_test!
        end
      end
    end

    path '/{game_id}/decks/{deck_id}/matches/{id}' do
      let(:match) { create(:match, deck:) }
      let(:deck_id) { deck.id }
      let(:id) { match.id }
      let(:game_id) { game.id }

      get 'Retrieve a match' do
        tags 'Matches'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: :game_id, in: :path, type: :string
        parameter name: :deck_id, in: :path, type: :string
        parameter name: :HTTP_FIREBASE_ID_TOKEN, in: :header, type: :string, required: true,
                  example: 'FIREBASE_ID_TOKEN: eyadadan...'

        response '200', 'Match found' do
          schema type: :object,
                 properties: {
                   id: { type: :string },
                   deck_id: { type: :string },
                   result: { type: :string },
                   bo3: { type: :boolean },
                   remarks: { type: :string },
                   coinflip_won: { type: :boolean },
                   archetype: { type: :object,
                                properties: {
                                  game_id: { type: :string },
                                  id: { type: :integer },
                                  identifier: { type: :string },
                                  name: { type: :string },
                                  generation: { type: :integer },
                                  cards: { type: :array },
                                  icons: { type: :array }
                                } },
                   opponent_archetype: { type: :object,
                                         properties: {
                                           game_id: { type: :string },
                                           id: { type: :integer },
                                           identifier: { type: :string },
                                           name: { type: :string },
                                           generation: { type: :integer },
                                           cards: { type: :array },
                                           icons: { type: :array }
                                         } },
                   match_games: { type: :array, items:
                     { type: :object,
                       properties: {
                         id: { result: :string },
                         game_id: { result: :string },
                         match_id: { type: :string },
                         started: { type: :boolean }
                       } },
                                  created_at: { type: :string },
                                  updated_at: { type: :string } },
                   required: %w[id deck_id result bo3 archetype opponent_archetype remarks]
                 }

          example 'application/json', :example_key, {
            id: 'ffff5d43-9173-4504-a576-4e50d9d98ba4',
            list_id: '389b987f-0633-4fb8-b834-619e57f6f097',
            deck_id: 'a22512c5-27db-49fc-b1fb-9d029720e3a2',
            bo3: false,
            coinflip_won: nil,
            remarks: '',
            result: 'L',
            opponent_archetype: {
              game_id: 'PTCG',
              id: 1,
              identifier: 'gardevoir-ex-sv',
              name: 'Gardevoir ex',
              generation: 9,
              cards: [
                {
                  name: 'Gardevoir ex',
                  count: '2'
                }
              ]
            },
            archetype: {
              game_id: 'PTCG',
              id: 1,
              identifier: 'gardevoir-ex-sv',
              name: 'Gardevoir ex',
              generation: 9,
              cards: [
                {
                  name: 'Gardevoir ex',
                  count: '2'
                }
              ]
            },
            match_games: [{
                            id: 'ffff5d43-9173-4504-a576-4e50d9d98ba4',
                            match_id: '0079aea2-c836-4d3f-9ea1-1063e4beae2f',
                            result: 'W',
                            started: true
                          }],
            created_at: DateTime.now,
            updated_at: DateTime.now
          }

          run_test!
        end

        response '401', 'unauthorized' do
          let(:HTTP_FIREBASE_ID_TOKEN) { '32113312' }
          run_test!
        end

        response '404', 'Match not found' do
          let(:id) { 'invalid' }

          run_test!
        end
      end
    end
  end
end
