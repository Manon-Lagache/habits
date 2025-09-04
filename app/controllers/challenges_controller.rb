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
    @challenge = Challenge.find(params[:id])
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
    @habits = current_user.habits
    @user = current_user
    @habit.build_goal
  end

  def join
    @challenge = Challenge.find(params[:id])
    @group = @challenge.group
    current_user.groups << @group
    redirect_to root_path, notice: "Challenge rejoint !"
    @user = current_user
    @user.gain_xp!(40)
  end
end
