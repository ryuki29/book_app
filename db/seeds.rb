15.times do |n|
  User.create!(
    email: "test#{n}@test.com",
    username: "テスト君#{n}号",
    password: "aaaaaa"
  )
end