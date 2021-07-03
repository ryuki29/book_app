FactoryBot.define do
  factory :sns_credential do
    provider { 'twitter' }
    uid { 123 }
    association :user
  end
end
