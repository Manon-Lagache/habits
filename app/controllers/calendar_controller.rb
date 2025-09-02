class CalendarController < ApplicationController
  def index
    if params[:month] && params[:year]
      @current_month = Date.new(params[:year].to_i, params[:month].to_i)
    else
      @current_month = Date.today.beginning_of_month
    end

    @previous_month = @current_month.prev_month
    @next_month     = @current_month.next_month

    @habits = current_user.habits.includes(:goal)

    @calendar_habits = Hash.new { |hash, key| hash[key] = [] }

    @habits.each do |habit|
      goal = habit.goal
      next unless goal.present?

      case goal.end_type
      when "period"
        debut = goal.start_date.presence || habit.created_at.to_date
        fin   = goal.end_date.presence   || debut
      when "target_date", "target_day"
        debut = habit.created_at.to_date
        fin   = goal.target_day.presence || debut
      when "indefinite"
        debut = habit.created_at.to_date
        fin   = debut + 5.years
      else
        debut = habit.created_at.to_date
        fin   = habit.created_at.to_date
      end

      next if debut.nil? || fin.nil? || fin < debut

      (debut..fin).each do |date|
        @calendar_habits[date] << habit
      end
    end
  end
end
