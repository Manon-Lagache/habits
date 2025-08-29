class HabitsController < ApplicationController
  before_action :set_collections, only: %i[new create]
  before_action :set_habit, only: [:show]

  def new
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def create
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to root_path, notice: "Habitude créée avec succès !"
    else
      @categories = Category.all
      @habit_types = HabitType.all
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
  end

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(
      :name,
      :category_id,
      :habit_type_id,
      :verb,
      :reminder,
      :reminder_time,
      :weekly_days => [],
      :monthly_days => [],
      :monthly_count => [],
      goal: [:value, :frequency, :end_type, :start_date, :end_date, :target_date]
    )
  end

  def set_collections
    @categories = Category.all
    @habit_types = HabitType.all
  end
end
