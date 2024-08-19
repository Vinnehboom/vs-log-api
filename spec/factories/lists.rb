FactoryBot.define do
  factory :list do
    deck
    name { Faker::Cosmere.shard }
    after(:build) do |list, _context|
      build(:card, list:, count: list.game.deck_card_count)
    end
  end
end
