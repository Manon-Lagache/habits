class HabitsController < ApplicationController

  def new
    @habit = current_user.habits.new
    @habit.build_goal
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def create
    @habit = current_user.habits.new(habit_params)
    @habit.save!
    if @habit.save
      redirect_to root_path, notice: "Habitude créée avec succès !"
    else
      render :new
    end
  end

  def home
    @habit = Habit.new
    @categories = Category.all
    @habit_types = HabitType.all
  end

  def show
    @habit = Habit.find(params[:id])
    @tips = @habit.tips
  end

  private

  def normalize_goal_params
    return unless params[:habit].present?

    # si le JS a envoyé habit[:goal] (map provenant du block JS), on le transforme
    if params[:habit][:goal].present?
      params[:habit][:goal_attributes] ||= {}
      # params[:habit][:goal] peut être un HashWithIndifferentAccess
      params[:habit][:goal].each do |k, v|
        # accepter target_date ou target_day du front et normaliser en target_day
        key = (k.to_s == "target_date" ? "target_day" : k)
        params[:habit][:goal_attributes][key] = v
      end
      params[:habit].delete(:goal)
    end
  end

  def habit_params
    params.require(:habit).permit(
      :name,
      :category_id,
      :habit_type_id,
      :verb_id,
      :visibility,
      goal_attributes: [
        :value, :frequency, :end_type, :start_date, :end_date, :target_day,
        tracking_config: {}
      ]
    )
  end

end