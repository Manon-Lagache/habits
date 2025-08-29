class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @habits = Habit.all
    @categories = Category.all
    @habit_types = HabitType.all
    @user = current_user
    @tips = Tip.all
    @habit = Habit.new
  end
end
