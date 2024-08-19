FactoryBot.define do
  factory :card do
    list
    count { 60 }
    name { Faker::Games::Pokemon.name }
    set_id { Faker::String.random }
    set_number { Faker::String.random }
  end
end
