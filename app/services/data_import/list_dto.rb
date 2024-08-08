module DataImport

  class ListDto < Dto

    private

    def attributes
      attributes = object.transform_keys { |key| key.to_s.underscore }
      attributes.delete('__collections__')
      attributes
    end

    def model
      List
    end

  end

end
