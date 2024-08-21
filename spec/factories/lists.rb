FactoryBot.define do
  factory :list do
    deck
    name { Faker::Cosmere.shard }
    after(:build) do |list, _context|
      list.cards = build_list(:card, 1, list:, count: list.deck.game.deck_card_count)
    end

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
