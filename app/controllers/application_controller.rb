class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_user!

  def index
    @activities = current_user.activities
    @hits_this_month = ActivityHit.select("activity_id, COUNT(*) as hits").
                         where(activity: @activities).this_month.
                         group(:activity_id).
                         map{ |record| [record.activity_id, record.hits] }.to_h
    @hits_past_month = ActivityHit.select("activity_id, COUNT(*) as hits").
                         where(activity: @activities).past_month.
                         group(:activity_id).
                         map{ |record| [record.activity_id, record.hits] }.to_h
  end
end
