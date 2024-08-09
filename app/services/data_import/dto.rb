module DataImport

  class Dto

    attr_accessor :object, :game

    def initialize(object:, game:)
      @object = object
      @game = game
    end

    def update_instance
      model.find_or_initialize_by(id: attributes['id']).update(attributes)
    end

    private

    def attributes
      model.has_attribute?(:game_id) ? model_attributes.merge(game_id: game.id) : model_attributes
    end

    def model_attributes
      raise '#attributes not implemented'
    end

    def model
      raise '#model not implemented'
    end

  end

end
