FactoryBot.define do
  factory :archetype do
    sequence(:identifier) { |n| "#{Faker::Games::Pokemon.name}-#{n}" }
    name { Faker::Games::Pokemon.name }
    priority { rand(25) }
    generation { rand(10) }
    cards do
      [{
        name: Faker::Games::Pokemon.name,
        count: rand(4)
      }]
    end
    game
  end
end
