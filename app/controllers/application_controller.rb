class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_user!

  def index
    @activities = current_user.activities.active.to_a
    @hits_this_month = ActivityHit.select("activity_id, COUNT(*) as hits").
                         where(activity: @activities).this_month.
                         group(:activity_id).
                         map { |record| [ record.activity_id, record.hits ] }.to_h
    @hits_past_month = ActivityHit.select("activity_id, COUNT(*) as hits").
                         where(activity: @activities).past_month.
                         group(:activity_id).
                         map { |record| [ record.activity_id, record.hits ] }.to_h
    @activities.sort_by! { |activity| (@hits_this_month[activity.id] || 0) + (@hits_past_month[activity.id] || 0) }.reverse!
    @daily_counts = ActivityHit.select("DATE(date), COUNT(*) as hits").
                      where("date > ?", 1.year.ago).
                      where(activity_id: @activities.map(&:id)).
                      group("DATE(date)").map { |item| [ item.date.to_s, item.hits ] }.to_h
  end
end
