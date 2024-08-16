FactoryBot.define do
  factory :game do
    id { Faker::Address.country_code + rand(10).to_s }
    name { Faker::Game.title }
    deck_card_count { 60 }
    exact_count { true }
  end
end
