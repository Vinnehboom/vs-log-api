module DataImport

  class ActiveListDto < Dto

    def id
      object['list']['id']
    end

    private

    def model_attributes
      {
        active: true
      }
    end

    def model
      List
    end

  end

end
