FactoryBot.define do
  factory :archetype do
    sequence(:identifier) { |n| "#{Faker::Games::Pokemon.name}-#{n}" }
    name { Faker::Games::Pokemon.name }
    priority { rand(25) }
    generation { rand(10) }
    cards { Faker::Types.rb_hash }
    game
  end
end
