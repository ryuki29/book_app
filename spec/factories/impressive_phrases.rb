FactoryBot.define do
  factory :impressive_phrase do
    phrase { Faker::Lorem.sentence }
    association :review
  end
end
