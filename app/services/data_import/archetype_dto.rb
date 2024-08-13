module DataImport

  class ArchetypeDto < Dto

    private

    def model_attributes
      {
        name: object['name'],
        identifier: object['identifier'],
        cards: object['cards'],
        generation: object[:generation] || object['generation'],
        priority: object['priority'],
        icons:
      }
    end

    def icons
      icons = object['icons'] || object[:icons]
      icons.map do |icon|
        next if icon.blank?

        {
          io: icon_source(icon),
          filename: "#{icon}.png"
        }
      end
    end

    def icon_source(icon)
      name = misc_names[icon.to_sym] || icon

      URI.open("https://raw.githubusercontent.com/martimlobao/pokesprite/master/pokemon/regular/#{name}.png")
    end

    def misc_names
      {
        ogerpon: 'ogerpon-teal-mask',
        'ogerpon-cornerstone': 'ogerpon-cornerstone-mask',
        'ogerpon-wellspring': 'ogerpon-wellspring-mask',
        'regieleki-a': 'regieleki',
        squawkabilly: 'squawkabilly-yellow'
      }
    end

    def model
      Archetype
    end

  end

end
