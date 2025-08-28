class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    redirect_to new_user_session_path unless user_signed_in?
    @habits = Habit.all
    @categories = Category.all
    @habit_types = HabitType.all
    @user = current_user
    @tips = Tip.all
  end
end
