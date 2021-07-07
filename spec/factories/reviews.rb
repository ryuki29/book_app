FactoryBot.define do
  factory :review do
    date        { Date.current }
    tegline     { Faker::Lorem.sentence }
    text        { Faker::Lorem.sentence }
    rating      { 3 }
    category    { 3 }
    association :user
    association :book
  end
end
