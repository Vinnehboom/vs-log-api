module DataImport

  class ActiveDeckDto < Dto

    def id
      object['deck']['id']
    end

    private

    def model_attributes
      {
        active: true
      }
    end

    def model
      Deck
    end

  end

end
