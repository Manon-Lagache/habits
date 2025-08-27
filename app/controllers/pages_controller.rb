class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
  end
end
