class HabitStepsController < ApplicationController
  include Wicked::Wizard
  steps :basic_info, :habit_choice, :goals, :visibility

  def show
    @habit = Habit.find(session[:habit_id]) if session[:habit_id]
    render_wizard
  end

  def update
    @habit = Habit.find(session[:habit_id])
    @habit.update(habit_params)
    render_wizard @habit
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :category, :habit_type_id, :visibility)
  end
end
