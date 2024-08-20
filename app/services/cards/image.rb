module Cards

  class Image

    attr_accessor :card

    def initialize(card:)
      @card = card
    end

    def url
      raise '#url not implemented'
    end

  end

end
