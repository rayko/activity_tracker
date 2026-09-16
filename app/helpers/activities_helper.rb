module ActivitiesHelper
  def activity_hits_display(activity)
    "|" * activity.activity_hits.count
  end
end
