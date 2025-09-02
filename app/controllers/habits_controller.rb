class HabitsController < ApplicationController

  def new
    @habit = current_user.habits.new
    @habit.build_goal
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def create
    @habit = current_user.habits.new(habit_params)
    @goal = @habit.build_goal(goal_params[:goal_attributes])
    if @habit.save! && @goal.save!
      LlmTipJob.perform_later(@habit.id)
      redirect_to root_path, notice: "Habitude créée avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def home
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def show
    @categories = Category.all
    @habit = Habit.find(params[:id])
    @tips = @habit.tips.order(created_at: :desc)
    @goal = Goal.find_by(habit: @habit)

    @habit_new = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
    @habits = current_user.habits
    @user = current_user
    @habit_new.build_goal
  end

  private

  def normalize_goal_params
    return unless params[:habit].present?

    if params[:habit][:goal].present?
      params[:habit][:goal_attributes] ||= {}
      params[:habit][:goal].each do |k, v|
        key = (k.to_s == "target_date" ? "target_day" : k)
        params[:habit][:goal_attributes][key] = v
      end
      params[:habit].delete(:goal)
    end
  end

     
  def goal_params
    permitted = params.require(:habit).permit(
      goal: [:start_date, :end_date, :target_day],
      goal_attributes: [:value, :frequency, :end_type, :start_date, :end_date]
    )

    if permitted[:goal].present?
      permitted[:goal_attributes] ||= {}
      permitted[:goal_attributes].merge!(permitted.delete(:goal))
    end

    permitted
  end

  def habit_params
    params.require(:habit).permit(
    :name, :category_id, :habit_type_id, :verb_id, :visibility, :reminder_enabled
  )
  end
end
