FactoryBot.define do
  factory :list do
    deck
    cards { [{ name: Faker::Games::Pokemon.name, 'count' => 60 }] }
    name { Faker::Cosmere.shard }
  end
end
