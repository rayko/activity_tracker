FactoryBot.define do
  factory :activity_hit do
    date { DateTime.now }
    activity { create :activity }
  end
end
