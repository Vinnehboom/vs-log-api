module DataImport

  class ListDto < Dto

    def id
      object['id']
    end

    private

    def model_attributes
      {
        deck_id:,
        cards_attributes:,
        name:
      }
    end

    def model
      List
    end

    def deck_id
      object['deckId']
    end

    def cards_attributes
      object['cards'].map do |card_object|
        {
          name: card_object['card']['name'].presence || 'missing name',
          count: card_object['count'].to_i,
          set_id: card_object['card']['setId'].presence || 'missing id',
          set_number: card_object['card']['setNumber'].presence || 'missing number',
          list_id: id
        }
      end
    end

    def name
      object['name'].presence || 'no name'
    end

  end

end
