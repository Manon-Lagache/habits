class HabitsController < ApplicationController
  before_action :set_collections, only: %i[new create]

  def new
    @habit = Habit.new
  end

  def create
    @habit = current_user.habits.new(habit_params)
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

  private

  def habit_params
    params.require(:habit).permit(
      :name, :habit_type_id, :action, :goal_value, :frequency, :end_date, :visibility,
      notification_attributes: %i[enabled time notification_type]
    )
  end

  def set_collections
    @categories = Category.all
    @habit_types = HabitType.all
  end
end
