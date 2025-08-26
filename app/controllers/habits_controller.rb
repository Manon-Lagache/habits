class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  def index
    @habits = current_user.habits
  end

  def show
  end

  def new
    @habit = current_user.habits.build
  end

  def create
    @habit = current_user.habits.build(habit_params)
    if @habit.save
      redirect_to @habit, notice: "Habit créé avec succès."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: "Habit mis à jour."
    else
      render :edit
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_path, notice: "Habit supprimé."
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :category, :habit_type_id, :visibility)
  end
end
