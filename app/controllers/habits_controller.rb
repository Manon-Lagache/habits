class HabitsController < ApplicationController
  # before_action :set_collections, only: %i[new create]
  # before_action :set_habit, only: [:show]

  def new
    @habit = current_user.habits.new
    @habit.build_goal
    @categories = Category.all
    @habit_types = HabitType.all
  end

  # def create
  #   raise
  #   @category = Category.find(params[:category_id])
  #   @habit = current_user.habits.new(habit_params)
  #   if @habit.save
  #     redirect_to root_path, notice: "Habit créé !"
  #   else
  #     @categories = Category.all
  #     @habit_types = HabitType.all
  #     render :new
  #   end
  # end


  def create
    puts "=" * 50
    puts "PARAMS REÇUS:"
    puts params[:habit].inspect
    puts "=" * 50
    
    puts "NAME: '#{params[:habit][:name]}'"
    puts "CATEGORY_ID: '#{params[:habit][:category_id]}'"
    puts "HABIT_TYPE_ID: '#{params[:habit][:habit_type_id]}'"
    puts "VERB_ID: '#{params[:habit][:verb_id]}'"
    puts "VERB: '#{params[:habit][:verb]}'"
    
    puts "=" * 50
    puts "PROBLEMES DETECTES:"
    puts "Category ID vide!" if params[:habit][:category_id].blank?
    puts "Habit Type ID vide!" if params[:habit][:habit_type_id].blank?
    puts "Verb ID vide!" if params[:habit][:verb_id].blank?
    
    raise "STOP - Le formulaire n'envoie pas les bons IDs"
  end

  
  private

  def habit_params
    params.require(:habit).permit(
      :name,
      # :verb
      # :category_id,
      # :habit_type_id,
      # :verb_id,
      # :reminder,
      # :reminder_time,
      # weekly_days: [],
      # monthly_days: [],
      # monthly_count: [],
      # goal_attributes: [:value, :frequency, :end_type, :start_date, :end_date, :target_date, :period]
    )
  end
end