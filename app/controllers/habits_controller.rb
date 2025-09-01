class HabitsController < ApplicationController

  def new
    @habit = current_user.habits.new
    @habit.build_goal
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def create
    @habit = current_user.habits.new(habit_params)
    @habit.save!
    if @habit.save
      redirect_to root_path, notice: "Habitude créée avec succès !"
    else
      render :new
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

  def habit_params
    params.require(:habit).permit(
      :name,
      :category_id,
      :habit_type_id,
      :verb_id,
      :visibility,
      :goal,
      goal_attributes: [
        :value, :frequency, :end_type, :start_date, :end_date, :target_day,
        tracking_config: {}
      ]
    )
  end

end
