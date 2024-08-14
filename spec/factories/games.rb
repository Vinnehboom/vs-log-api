FactoryBot.define do
  factory :game do
    id { Faker::Address.country_code + rand(10).to_s }
    name { Faker::Game.title }
  end
end
