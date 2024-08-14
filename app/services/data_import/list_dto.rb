module DataImport

  class ListDto < Dto

    def id
      object['id']
    end

    private

    def model_attributes
      {
        deck_id:,
        cards:,
        name:
      }
    end

    def model
      List
    end

    def deck_id
      object['deckId']
    end

    def cards
      object['cards']
    end

    def name
      object['name'].presence || 'no name'
    end

  end

end
