FactoryBot.define do
  factory :board_comment do
    text { Faker::Lorem.sentence }
    association :board
    association :user
  end
end
