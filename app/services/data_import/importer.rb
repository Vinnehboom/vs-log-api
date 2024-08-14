module DataImport

  class Importer

    attr_accessor :dto_class, :parser, :game

    def initialize(dto_class:, parser:, game:)
      @dto_class = dto_class
      @parser = parser
      @game = game
    end

    def import(data:)
      objects = parse_data(data:)
      count = objects.count
      @processed = 0
      @errors = []
      process_objects(objects:)
      Rails.logger.debug { "invalid objects: #{@errors} \n" }
      Rails.logger.debug { "#{@processed} out of #{count} processed" }
    end

    private

    def process_objects(objects:)
      objects.each do |object|
        dto = dto_class.new(object:, game:)
        @processed += 1 if dto.update_instance
      rescue ActiveRecord::RecordInvalid => e
        @errors << [dto.object, e.message]
      end
    end

    def parse_data(data:)
      parser.parse(data:)
    end

  end

end
