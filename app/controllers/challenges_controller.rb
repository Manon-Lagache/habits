class ChallengesController < ApplicationController
  def index
    @challenges = current_user.available_challenges
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
    @habits = current_user.habits
    @user = current_user
    @habit.build_goal
  end

  def show
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
    @habits = current_user.habits
    @user = current_user
    @habit.build_goal
  end
end
