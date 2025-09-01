class HabitsController < ApplicationController

  def new
    @habit = current_user.habits.new
    @habit.build_goal
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def create
    @habit = current_user.habits.new(habit_params)
    @goal = @habit.build_goal(goal_params[:goal_attributes])
    if @habit.save! && @goal.save!
      redirect_to root_path, notice: "Habitude créée avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def home
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def show
    @habit = Habit.find(params[:id])
    @tips = @habit.tips
    @goal = Goal.find_by(habit: @habit)
  end

  private

  def goal_params
    permitted = params.require(:habit).permit(
      goal: [:start_date, :end_date, :target_day],
      goal_attributes: [:value, :frequency, :end_type, :start_date, :end_date]
    )

    # merge `goal` into `goal_attributes` if it exists
    if permitted[:goal].present?
      permitted[:goal_attributes] ||= {}
      permitted[:goal_attributes].merge!(permitted.delete(:goal))
    end

    permitted
  end

  def habit_params
    params.require(:habit).permit(
    :name, :category_id, :habit_type_id, :verb_id, :visibility, :reminder_enabled
  )
  end
end
