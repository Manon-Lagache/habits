class PagesController < ApplicationController

  def home
    @categories = Category.all
    @habit_types = HabitType.all
    @habits = current_user.habits
    @user = current_user
    @tips = Tip.all
    @daily_tips = Tip.where(tip_type: "daily", habit: @habits) 
    @trackers = @habits.map{|h| h.trackers.build}
    @habit = Habit.new
    @habit.build_goal
    @challenges = current_user.display_challenges
  end
end
