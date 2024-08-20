module Cards

  class PokemonTcgImage < Image

    def url
      "https://images.pokemontcg.io/#{api_set_id}/#{set_number}.png"
    end

    private

    def api_set_id
      Pokemon::API_SET_IDS[card.set_id.to_sym] || 'sve'
    end

    def set_number
      special_set_number(set_number: card.set_number, set_id: card.set_id) || card.set_number
    end

    def special_set_number(set_number:, set_id:)
      return unless %w[TG GG PR].any? { |str| set_id.include?(str) }

      return trainer_gallery_set_number(set_number:) if set_id.include?('TG')
      return promo_set_number(set_number:, set_id:) if set_id.include?('PR')

      galar_gallery_set_number(set_number:)
    end

    def trainer_gallery_set_number(set_number:)
      "TG#{set_number}"
    end

    def promo_set_number(set_number:, set_id:)
      promo_translations = {
        'PR-SW' => 'SWSH',
        'PR-SV' => '',
        'PR-BLW' => 'BW',
        'PR-DPP' => 'DP',
        'PR-HS' => 'HGSS',
        'PR-NP' => '',
        'PR-SM' => 'SM',
        'PR-XY' => 'XY'
      }

      "#{promo_translations[set_id]}#{set_number}"
    end

    def galar_gallery_set_number(set_number:)
      "GG#{set_number}"
    end

  end

end
