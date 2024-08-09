FactoryBot.define do
  factory :game do
    id { Faker::Address.country_code }
    name { Faker::Game.title }
  end
end
