FactoryBot.define do
  factory :user_book do
    status      { 0 }
    association :user
    association :book
  end
end
