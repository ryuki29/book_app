FactoryBot.define do
  factory :like do
    user { review.user }
    association :review
  end
end
