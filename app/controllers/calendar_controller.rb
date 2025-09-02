class CalendarController < ApplicationController
  def index
    # Déterminer le mois affiché
    if params[:month] && params[:year]
      @current_month = Date.new(params[:year].to_i, params[:month].to_i)
    else
      @current_month = Date.today.beginning_of_month
    end

    @previous_month = @current_month.prev_month
    @next_month     = @current_month.next_month

    @habits = current_user.habits.includes(:goal)

    # Initialisation du hash pour le calendrier
    @calendar_habits = Hash.new { |hash, key| hash[key] = [] }

    @habits.each do |habit|
      goal = habit.goal
      next unless goal.present?

      # Définir début et fin selon end_type
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

      # Sécurité : on ne met que si début et fin sont valides
      next if debut.nil? || fin.nil? || fin < debut

      # Remplir le calendrier pour chaque jour entre début et fin
      (debut..fin).each do |date|
        @calendar_habits[date] << habit
      end
    end
  end
end
