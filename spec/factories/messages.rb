FactoryBot.define do
  factory :message do
    message     { Faker::Lorem.word }
    association :room
    association :user
  end
end
