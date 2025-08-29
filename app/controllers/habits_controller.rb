class HabitsController < ApplicationController

  def new
    @habit = current_user.habits.new
    @habit.build_goal
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def create
    @habit = current_user.habits.new(habit_params)
    raise @habit.inspect
    @habit.save!
  end

  private

  def habit_params
    params.require(:habit).permit(
      :name,
      :category_id,
      :habit_type_id,
      :verb_id,
      goal_attributes: [
        :value, :frequency, :end_type, :start_date, :end_date, :target_day,
        tracking_config: {}
      ]
    )
  end

end