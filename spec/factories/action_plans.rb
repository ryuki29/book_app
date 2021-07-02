FactoryBot.define do
  factory :action_plan do
    plan        { Faker::Lorem.sentence }
    deadline    { Date.today }
    association :review
  end
end
