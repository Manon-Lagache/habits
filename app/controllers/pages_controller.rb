class PagesController < ApplicationController

  def home
    @categories = Category.all
    @habit_types = HabitType.all
    @habits = current_user.habits.order(created_at: :desc) 
    @user = current_user
    @tips = Tip.all
    @daily_tips = Tip.where(tip_type: "daily", habit: @habits) 
    @trackers = @habits.select{|h| h.has_goal_for_date?(Date.today)}.map{|h| h.trackers.build}
    @habit = Habit.new
    @habit.build_goal
    @challenges = current_user.display_challenges
  end
end
