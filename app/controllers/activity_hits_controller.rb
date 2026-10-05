class ActivityHitsController < ApplicationController
  before_action :set_resource

  def destroy
    @resource.destroy!
    redirect_to activity_path(@resource.activity_id), notice: "Activity Hit destroyed.", status: :see_other
  end

  private

  def set_resource
    @resource = ActivityHit.find(params.expect(:id))
  end
end
