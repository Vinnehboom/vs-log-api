module Pokemon
  API_SET_IDS = {}
  Pokemon::Set.all.each { |set| API_SET_IDS[set.ptcgo_code] = set.id }
end