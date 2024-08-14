module DataImport

  class MatchDto < Dto

    def id
      object['id']
    end

    private

    def model_attributes
      {
        archetype:,
        opponent_archetype:,
        deck:,
        list:,
        bo3:,
        result:,
        remarks:,
        coinflip_won:,
        created_at:
      }
    end

    def model
      Match
    end

    def archetype
      identifier = object['deckArchetype']['identifier'] || object['deckArchetype']
      Archetype.find_by(identifier:)
    end

    def opponent_archetype
      identifier = object['opponentArchetype']['identifier'] || object['opponentArchetype']
      Archetype.find_by(identifier:)
    end

    def coinflip_won
      return object['coinFlipWon'] unless bo3

      object['coinFlipWon'].present?
    end

    def deck
      Deck.find_by(id: object['deckId'])
    end

    def list
      List.find_by(id: object['listId'])
    end

    def bo3
      object['bo3']
    end

    def result
      object['result']
    end

    def remarks
      object['remarks']
    end

    def created_at
      (object['createdAt'] && DateTime.parse(object['createdAt']['__time__'])) || DateTime.now
    end

  end

end
