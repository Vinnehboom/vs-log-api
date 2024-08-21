module Lists

  class PokemonTcgParser < Parser

    def parse_game_cards(cards:)
      build_cards(cards:)
    end

    def build_cards(cards:)
      parsed_cards = cards.map do |card_string|
        card_string.slice!('PH')
        quantity, *name_parts, set_id, set_number = card_string.split
        next unless quantity

        { count: quantity.to_i, name: name_parts.join(' '), set_id:, set_number: }
      end

      parsed_cards.compact.reject { |card| card[:count] < 1 }
    end

  end

end
