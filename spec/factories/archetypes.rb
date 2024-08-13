FactoryBot.define do
  factory :archetype do
    identifier { Faker::Games::Pokemon.name }
    name { Faker::Games::Pokemon.name }
    priority { rand(25) }
    generation { rand(10) }
    cards { Faker::Types.rb_hash }
    game
  end
end
