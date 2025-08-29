class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    redirect_to new_user_session_path unless user_signed_in?
  
    @categories = Category.all
    @habit_types = HabitType.all
    @user = current_user
    @tips = Tip.all
    @habits = current_user.habits
    @trackers = @habits.map{|h| h.trackers.build}
  end
end
