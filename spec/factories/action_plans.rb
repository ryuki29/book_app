FactoryBot.define do
  factory :action_plan do
    plan        { Faker::Lorem.sentence }
    deadline    { Date.current }
    association :review
  end
end
