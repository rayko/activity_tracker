class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy register_hit unregister_hit ]

  def register_hit
    if @activity.activity_hits.today.any?
      flash[:alert] = "Already registered today"
    else
      @activity.activity_hits.create!(date: DateTime.now)
      flash[:notice] = "Registered hit"
    end
    redirect_to root_path
  end

  def unregister_hit
    if !@activity.activity_hits.today.any?
      flash[:alert] = "No hits today"
    else
      @activity.activity_hits.today.take.destroy
      flash[:notice] = "Unregistered hit"
    end
    redirect_to root_path
  end

  def index
    @activities = Activity.all
  end

  def show
  end

  def new
    @activity = Activity.new
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id

    if @activity.save
      redirect_to root_path, notice: "Activity was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: "Activity was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @activity.destroy!
    redirect_to root_path, notice: "Activity was successfully destroyed.", status: :see_other
  end

  private
  def set_activity
    @activity = Activity.find(params.expect(:id))
  end

  def activity_params
    params.fetch(:activity, {}).permit(:name, :description)
  end
end
