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

    redirect_to calendar_index_path(month: date_param.month, year: date_param.year), notice: "Trackers enregistrés !"
  end

  def show
  end

  private

  def tracker_params
    params.require("[trackers]").permit!
  end
end
