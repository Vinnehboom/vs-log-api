FactoryBot.define do
  factory :match do
    list
    deck
    opponent_archetype factory: %i[archetype]
    archetype
    bo3 { [true, false].sample }
    coinflip_won { [true, false].sample }
    remarks { Faker::String.random.tr("\u0000", '') }
    result { Match.results.sample }
  end
end
