class TrackersController < ApplicationController
  def new
  end


  {"authenticity_token"=>"[FILTERED]", "[trackers]"=>{"0"=>{"habit_id"=>"13", "value"=>"7"}}}
  def create

    date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today
    trackers = tracker_params
    trackers.each do |tracker|
      if Tracker.find(tracker.last["habit_id"])
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

  def create_or_update
    @habit = Habit.find(params[:id])
    @trackers = @habit.trackers
    @tracker = @trackers.where("date = ?", Date.today)
    date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today

    if @tracker.nil?
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
    else
      @tracker.update!(
        value: tracker.last.require(:value),
        habit_id: @habit,
        date: date_param
      )
    end
    respond_to do |format|
      format.json { render json: trackers }
      format.html { redirect_to root_path }
    end
  end

  private

  def tracker_params
    params.require("[trackers]").permit!
  end
end
