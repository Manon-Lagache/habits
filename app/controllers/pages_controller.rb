class PagesController < ApplicationController

  def home
    @categories = Category.all
    @habit_types = HabitType.all
    @habits = current_user.habits
    @user = current_user
    @tips = Tip.all
    @habits = current_user.habits
    @trackers = @habits.map{|h| h.trackers.build}
    @habit = Habit.new
    @habit.build_goal
  end
end
