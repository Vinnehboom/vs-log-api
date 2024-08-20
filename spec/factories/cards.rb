FactoryBot.define do
  factory :card do
    list factory: %i[list skip_validate]
    count { 60 }
    name { Faker::Games::Pokemon.name }
    set_id { Faker::String.random.tr("\u0000", '') }
    set_number { Faker::String.random.tr("\u0000", '') }
  end
end
