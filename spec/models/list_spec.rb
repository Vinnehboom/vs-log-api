require 'rails_helper'

RSpec.describe List do
  it { is_expected.to belong_to(:deck) }
  it { is_expected.to have_many(:matches) }
  it { is_expected.to validate_presence_of(:name) }

  describe '#active' do
    describe 'when updating a decks active list' do
      let(:deck) { create(:deck) }
      let(:lists) { create_list(:list, 3, deck:, active: false) }

      it 'sets the list as active' do
        list = lists.sample
        list.update(active: true)
        expect(list.reload).to be_active
      end

      describe 'when the deck had a previous active list' do
        let!(:active_list) do
          list = lists.first
          list.update(active: true)
          list
        end

        it 'sets the previous list as inactive' do
          list = lists.second
          list.update(active: true)
          expect(active_list.reload).not_to be_active
        end
      end
    end
  end
end
