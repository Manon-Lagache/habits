class TrackersController < ApplicationController

  def new

  end

  def create
    trackers = tracker_params
    trackers.each do |tracker|
      Tracker.create(value: tracker.last.require(:value), habit_id: tracker.last.require(:habit_id), date: Date.today)
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
