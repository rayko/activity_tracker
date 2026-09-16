FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { generate(:user_email) }
    password { "123456" }
  end
end
