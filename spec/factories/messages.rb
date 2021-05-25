FactoryBot.define do
  factory :message do
    user { nil }
    room { nil }
    message { "MyText" }
  end
end
