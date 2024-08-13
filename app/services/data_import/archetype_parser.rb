module DataImport

  class ArchetypeParser

    def parse(data:)
      archetypes = []
      data.each do |archetype|
        archetypes.push(*variants(archetype))
        archetypes.push(archetype)
      end
      archetypes
    end

    def variants(archetype)
      archetype['variants'].map do |variant|
        variant.merge(
          generation: archetype['generation'],
          icons: archetype['icons'] + [variant['icon']],
          cards: archetype['cards'] + variant['cards']
        )
      end
    end

  end

end
