FactoryBot.define do
  sequence :activity_name do |n|
    "Activity - #{n}"
  end

  sequence :user_email do |n|
    "example#{n}@example.com"
  end
end
