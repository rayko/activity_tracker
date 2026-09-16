class ActivityHit < ApplicationRecord
  belongs_to :activity

  scope :today, -> { where("date BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day) }
end
