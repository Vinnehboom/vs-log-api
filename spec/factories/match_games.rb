FactoryBot.define do
  factory :match_game do
    association :match # rubocop:disable FactoryBot/AssociationStyle
    result { %w[W L T].sample }
    started { [true, false].sample }
  end
end
