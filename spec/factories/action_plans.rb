FactoryBot.define do
  factory :action_plan do
    plan { Faker::Lorem.sentence }
    association :review
  end
end
