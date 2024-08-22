require 'rails_helper'

RSpec.describe ArchetypesController do
  before do
    FirebaseIdToken.test!
    request.headers['HTTP_FIREBASE_ID_TOKEN'] = create_firebase_userid_token(user: firebase_user_id)
  end

  let(:game) { create(:game) }

  describe '#index' do
    it 'returns all archetypes for the game' do
      game_archetypes = create_list(:archetype, 2, game:)
      other_game_archetypes = create_list(:archetype, 2)
      get :index, params: { game: game.id }, format: :json
      expect(assigns(:archetypes)).to include(*game_archetypes)
      expect(assigns(:archetypes)).not_to include(*other_game_archetypes)
    end

    describe 'when filtering for identifier' do
      it 'includes all archetypes whose identifier contains the query' do
        archetype1 = create(:archetype, game:, identifier: 'arcanine')
        archetype2 = create(:archetype, game:, identifier: 'charcadet')
        other_archetype = create(:archetype, game:, identifier: 'blastoise')
        get :index, params: { game: game.id, identifier: 'arc' }, format: :json
        expect(assigns(:archetypes)).to include(archetype1, archetype2)
        expect(assigns(:archetypes)).not_to include(other_archetype)
      end
    end

    describe 'when filtering for name' do
      it 'includes all archetypes whose name contains the query' do
        archetype1 = create(:archetype, game:, name: 'Arceus')
        archetype2 = create(:archetype, game:, name: 'Archaludon')
        other_archetype = create(:archetype, game:, name: 'blastoise')
        get :index, params: { game: game.id, name: 'arc' }, format: :json
        expect(assigns(:archetypes)).to include(archetype1, archetype2)
        expect(assigns(:archetypes)).not_to include(other_archetype)
      end
    end

    describe 'when filtering for name and identifier' do
      it 'includes all archetypes whose name and identifer contain the query' do
        archetype1 = create(:archetype, game:, name: 'Arceus', identifier: 'arc')
        archetype2 = create(:archetype, game:, name: 'Archaludon', identifier: 'archaludon')
        only_name = create(:archetype, game:, name: 'Arceus', identifier: '2')
        only_identifier = create(:archetype, game:, identifier: 'rco')
        other_archetype = create(:archetype, game:, name: 'blastoise')
        get :index, params: { game: game.id, name: 'arc', identifier: 'rc' }, format: :json
        expect(assigns(:archetypes)).to include(archetype1, archetype2)
        expect(assigns(:archetypes)).not_to include(other_archetype, only_name, only_identifier)
      end
    end
  end
end
