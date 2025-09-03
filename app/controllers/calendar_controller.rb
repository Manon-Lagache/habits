class CalendarController < ApplicationController
  def index
    # — Sélection du mois/année (fallback = aujourd’hui)
    year_param  = (params[:year]  || Date.today.year).to_i
    month_param = (params[:month] || Date.today.month).to_i
    @current_month = Date.new(year_param, month_param, 1)

    @previous_month = @current_month.prev_month
    @next_month     = @current_month.next_month

    # Fenêtre visible = du début du mois précédent (aligné lundi) à la fin du mois suivant (aligné dimanche)
    visible_start = @previous_month.beginning_of_month.beginning_of_week(:monday)
    visible_end   = @next_month.end_of_month.end_of_week(:sunday)

    # On charge tout ce qu’il faut d’un coup
    @habits = current_user.habits
                          .includes(:category, :goal)
    habit_ids = @habits.map(&:id)

    # Hash des habitudes actives par date (pour les pastilles couleurs)
    @habits_by_date = Hash.new { |h, k| h[k] = [] }

    # Hash des trackers par date (si tu veux un deuxième indicateur)
    @trackers_by_date = Hash.new { |h, k| h[k] = [] }
    Tracker.where(habit_id: habit_ids, date: visible_start..visible_end).find_each do |t|
      @trackers_by_date[t.date] << t
    end

    # Utilitaire petit mais sûr
    cast_to_date = ->(val) do
      return nil if val.nil?
      return val.to_date if val.respond_to?(:to_date)
      Date.parse(val.to_s) rescue nil
    end

    # Remplissage des jours couverts par chaque habit selon son goal
    @habits.each do |habit|
      goal = habit.goal
      next unless goal.present?

      # On calcule "debut" / "fin" (en VRAIES dates)
      debut =
        case goal.end_type
        when "period"
          cast_to_date.(goal.start_date) || habit.created_at.to_date
        when "target_date", "target_day"
          habit.created_at.to_date
        when "indefinite"
          habit.created_at.to_date
        else
          habit.created_at.to_date
        end

      fin =
        case goal.end_type
        when "period"
          cast_to_date.(goal.end_date) || debut
        when "target_date", "target_day"
          cast_to_date.(goal.target_day) || debut
        when "indefinite"
          debut + 5.years
        else
          debut
        end

      # Sécurité & clamp sur la fenêtre visible
      next if debut.nil? || fin.nil? || fin < debut

      range_start = [debut, visible_start].max
      range_end   = [fin,   visible_end].min

      (range_start..range_end).each do |day|
        @habits_by_date[day] << habit
      end
    end
  end
end
