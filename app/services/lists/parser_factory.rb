module Lists

  class ParserFactory < ApplicationService

    attr_accessor :game, :list_lines

    def initialize(game:)
      @game = game
      super()
    end

    def call
      parser_class = case game.id
                     when 'PTCG'
                       PokemonTcgParser
                     else
                       Parser
                     end
      parser_class.new
    end

  end

end
