module DataImport

  class DeckDto < Dto

    def id
      object['id']
    end

    private

    def model_attributes
      {
        name:,
        user_id:,
        archetype_id: archetype.id
      }
    end

    def model
      Deck
    end

    def name
      object['name']
    end

    def user_id
      object['userId']
    end

    def archetype
      Archetype.find_by(identifier: object['archetype']['identifier'] || object['archetype'])
    end

  end

end
