class TrackersController < ApplicationController


  def new
  end

  def create
    date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @user = current_user
    trackers = tracker_params
    trackers.each do |tracker|
      Tracker.create!(
        value: tracker.last.require(:value),
        habit_id: tracker.last.require(:habit_id),
        date: date_param
      )
      if tracker
        @user.gain_xp!
      end
    end

    redirect_to root_path

  end

  def show
  end

  private

  def tracker_params
    params.require("[trackers]").permit!
  end
end
