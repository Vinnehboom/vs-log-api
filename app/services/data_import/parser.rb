module DataImport

  class Parser

    def parse(data:)
      data['data'].pluck(1)
    end

  end

end
