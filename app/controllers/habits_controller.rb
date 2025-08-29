class HabitsController < ApplicationController
  # before_action :set_collections, only: %i[new create]
  # before_action :set_habit, only: [:show]

  def new
    @habit = current_user.habits.new
    @habit.build_goal
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def create

    @category = Category.find(params[:category_id])
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to root_path, notice: "Habit créé !"
    else
      @categories = Category.all
      @habit_types = HabitType.all
      render :new
    end
  end

  private

  def habit_params
    params.require(:habit).permit(
      :name,
      :category_id,
      :habit_type_id,
      :verb_id,
      :reminder,
      :reminder_time,
      weekly_days: [],
      monthly_days: [],
      monthly_count: [],
      goal_attributes: [
        :value, :frequency, :end_type, :start_date, :end_date, :target_day
      ]
    )
  end

end