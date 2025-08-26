class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @habits = Habit.all
    # @test = @habits.slice(2)
    # raise
  end
end
