class TrackersController < ApplicationController
  def new
    date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today

    user_habits = current_user.habits.includes(:habit_type, :goal)
    @trackers = user_habits.select do |habit|
      goal = habit.goal
      next false unless goal

      start_date = goal.start_date || habit.created_at.to_date
      end_date   = goal.end_date   || (goal.end_type == "indefinite" ? start_date + 5.years : start_date)

      date_param >= start_date && date_param <= end_date
    end.map do |habit|
      Tracker.find_or_initialize_by(habit: habit, date: date_param)
    end

    @date = date_param
    render partial: "trackers/form", locals: { trackers: @trackers, date: @date }
  end

  def create
    date_param = params[:date].present? ? Date.parse(params[:date]) : Date.today

    tracker_params.each do |_, tracker|
      Tracker.create_or_find_by!(
        habit_id: tracker[:habit_id],
        date: date_param
      ).update!(value: tracker[:value])
    end

    redirect_to root_path
  end

  private

  def tracker_params
    params.require(:trackers).permit!
  end
end
