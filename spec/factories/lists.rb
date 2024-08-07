FactoryBot.define do
  factory :list do
    deck
    cards { Faker::Types.rb_hash }
    name { Faker::Cosmere.shard }
  end
end
