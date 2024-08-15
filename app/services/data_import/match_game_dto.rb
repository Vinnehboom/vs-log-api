module DataImport

  class MatchGameDto < Dto

    def id
      object['id']
    end

    private

    def model_attributes
      {
        match:,
        result:,
        started:,
        created_at:
      }
    end

    def model
      MatchGame
    end

    def match
      Match.find_by(id: object['matchRecordId'])
    end

    def result
      object['result']
    end

    def started
      object['started']
    end

    def created_at
      (object['createdAt'] && DateTime.parse(object['createdAt']['__time__'])) || DateTime.now
    end

  end

end
