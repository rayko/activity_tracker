class ActivityHit < ApplicationRecord
  belongs_to :activity

  scope :recent, -> { where("date BETWEEN ? AND ?", 8.hours.ago, DateTime.now) }
  scope :today, -> { where("date BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day) }
  scope :this_month, -> { where("date BETWEEN ? AND ?", DateTime.now.beginning_of_month, DateTime.now.end_of_month) }
  scope :past_month, -> { where("date BETWEEN ? AND ?", 1.month.ago.beginning_of_month, 1.month.ago.end_of_month) }

  validates :date, presence: true
end
