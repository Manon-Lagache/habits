class TrackersController < ApplicationController


  def new
  end

def create

    @user = current_user
    date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today
    trackers = tracker_params
    trackers.each do |tracker|
      habit = Habit.find(tracker.last["habit_id"])
      if habit && habit.has_tracker_for_date?(Date.today)
        puts "Updating tracker for habit #{habit.id} on #{Date.today}"
        @tracker = habit.trackers.where("date = ?", Date.today).first
        puts @tracker.value
        puts "value: #{tracker.last.require(:value)}"
        @tracker.update(value: tracker.last.require(:value))
        puts @tracker.value
      else
        Tracker.create!(
          value: tracker.last.require(:value),
          habit_id: tracker.last.require(:habit_id),
          date: date_param
        )
        if tracker
          @user.gain_xp!
        end
      end
    end

    respond_to do |format|
      format.json { render json: trackers }
      format.html { redirect_to root_path }
    end
  end


  def show
  end

  # def create_or_update
  #   @habit = Habit.find(params[:id])
  #   @trackers = @habit.trackers
  #   @tracker = @trackers.where("date = ?", Date.today)
  #   date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today

  #   if @tracker.nil?
  #     trackers = tracker_params
  #     trackers.each do |tracker|
  #       Tracker.create!(
  #         value: tracker.last.require(:value),
  #         habit_id: tracker.last.require(:habit_id),
  #         date: date_param
  #       )
  #     end
  #     respond_to do |format|
  #       format.json { render json: trackers }
  #       format.html { redirect_to root_path }
  #     end
  #   else
  #     @tracker.update!(
  #       value: tracker.last.require(:value),
  #       habit_id: @habit,
  #       date: date_param
  #     )
  #   end
  #   respond_to do |format|
  #     format.json { render json: trackers }
  #     format.html { redirect_to root_path }
  #   end
  # end

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
