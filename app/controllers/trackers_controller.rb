class TrackersController < ApplicationController
  def new
  end

  def create
    trackers = tracker_params

    trackers.each do |_, tracker|
      Tracker.create!(
        value: tracker[:value],
        habit_id: tracker[:habit_id],
        date: params[:date].present? ? Date.parse(params[:date]) : Date.today
      )
    end

    redirect_to root_path, notice: "Trackers enregistrés"
  end


  def show
  end

  private

  def tracker_params
    if params[:trackers].present?
      params.require(:trackers).permit!
    elsif params[:"[trackers]"].present?
      params.require("[trackers]").permit!
    else
      {}
    end
  end
end
