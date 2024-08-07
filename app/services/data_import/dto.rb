module DataImport

  class Dto

    attr_accessor :object

    def initialize(object:)
      @object = object
    end

    def update_instance
      model.find_or_initialize_by(id: attributes['id']).update(attributes)
    end

    private

    def attributes
      raise '#attributes not implemented'
    end

    def model
      raise '#model not implemented'
    end

  end

end
