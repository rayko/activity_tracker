class ActivityHit < ApplicationRecord
  belongs_to :activity

  scope :today, -> { where(date: Date.today) }
end
