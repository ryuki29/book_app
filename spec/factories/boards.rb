FactoryBot.define do
  factory :board do
    title       { Faker::Lorem.sentence }
    board_type  { 1 }
    description { Faker::Lorem.sentence }
    association :comment, factory: :board_comments
    association :user
  end
end
