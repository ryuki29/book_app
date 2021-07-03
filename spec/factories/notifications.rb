FactoryBot.define do
  factory :notification do
    visitor { nil }
    visited { nil }
    review { nil }
    comment { nil }
    action { "MyString" }
    checked { false }
  end
end
