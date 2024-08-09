FactoryBot.define do
  factory :deck do
    id { Faker::Internet.uuid }
    name { Faker::Game.title }
    user_id { Faker::Internet.uuid }
    archetype { Faker::Types.rb_hash }
    game
  end
end
