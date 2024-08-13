FactoryBot.define do
  factory :match_record do
    list
    deck
    opponent_archetype factory: %i[archetype]
    archetype
    bo3 { [true, false].sample }
    coinflip_won { [true, false].sample }
    remarks { Faker::String.random }
    result { MatchRecord.results.keys.sample }
  end
end
