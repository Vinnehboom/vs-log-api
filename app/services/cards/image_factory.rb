module Cards

  class ImageFactory < ApplicationService

    attr_accessor :game, :card

    def initialize(card:, game:)
      @game = game
      @card = card
      super()
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
