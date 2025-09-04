class TrackersController < ApplicationController
  def new
  end

  def create
    date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today
    trackers = tracker_params
    trackers.each do |tracker|
      Tracker.create!(
        value: tracker.last.require(:value),
        habit_id: tracker.last.require(:habit_id),
        date: date_param
      )
    end

    respond_to do |format|
      format.json { render json: trackers }
      format.html { redirect_to root_path }
    end

  end

  def show
  end

  private

  def tracker_params
    params.require("[trackers]").permit!
  end
end
