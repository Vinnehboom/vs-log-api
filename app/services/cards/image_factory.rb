module Cards

  class ImageFactory

    attr_accessor :game, :card

    def initialize(card:, game:)
      @game = game
      @card = card
    end

    def self.call(...)
      new(...).call
    end

    def call
      image_class = case game.id
                    when 'PTCG'
                      PokemonTcgImage
                    else
                      Image
                    end
      image_class.new(card:)
    end

  end

end
