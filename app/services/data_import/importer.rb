module DataImport

  class Importer

    attr_accessor :dto_class, :parser

    def initialize(dto_class:, parser:)
      @dto_class = dto_class
      @parser = parser
    end

    def import(data:)
      objects = parse_data(data:)
      objects.each do |object|
        dto = dto_class.new(object:)
        dto.update_instance
      end
    end

    private

    def parse_data(data:)
      parser.parse(data:)
    end

  end

end
