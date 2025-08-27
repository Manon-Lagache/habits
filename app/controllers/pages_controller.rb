class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @habits = Habit.all
    @categories = Category.all
    @habit_types = HabitType.all
  end
end
