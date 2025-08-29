class TrackersController < ApplicationController

  def new
    @habits = current_user.habits
    @tracker = Tracker.new
  end

  def create
  end

  def show

  end
end
