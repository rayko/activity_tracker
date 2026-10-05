FactoryBot.define do
  factory :activity do
    name { generate(:activity_name) }
    description { "Random activity" }
    user { create(:user) }
    archived { false }
  end
end
