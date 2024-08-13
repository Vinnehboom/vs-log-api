module DataImport

  class DeckDto < Dto

    private

    def model_attributes
      archetype = find_archetype
      attributes = object.transform_keys { |key| key.to_s.underscore }
      attributes['archetype_id'] = archetype.id
      attributes.delete('__collections__')
      attributes.delete('archetype')
      attributes
    end

    def model
      Deck
    end

    def find_archetype
      Archetype.find_by(identifier: object['archetype']['identifier'] || object['archetype'])
    end

  end

end
