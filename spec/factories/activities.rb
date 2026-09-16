FactoryBot.define do
  factory :activity do
    name { generate(:activity_name) }
    description { "Random activity" }
    user { create(:user) }
  end
end
