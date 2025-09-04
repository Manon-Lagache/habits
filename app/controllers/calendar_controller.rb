class CalendarController < ApplicationController
  def index
    year_param  = (params[:year]  || Date.today.year).to_i
    month_param = (params[:month] || Date.today.month).to_i
    @current_month = Date.new(year_param, month_param, 1)

    @user = current_user
    
    @previous_month = @current_month.prev_month
    @next_month     = @current_month.next_month

    visible_start = @previous_month.beginning_of_month.beginning_of_week(:monday)
    visible_end   = @next_month.end_of_month.end_of_week(:sunday)

    @habits = current_user.habits
                          .includes(:category, :goal)
    habit_ids = @habits.map(&:id)

    @habits_by_date = Hash.new { |h, k| h[k] = [] }

    @trackers_by_date = Hash.new { |h, k| h[k] = [] }
    Tracker.where(habit_id: habit_ids, date: visible_start..visible_end).find_each do |t|
      @trackers_by_date[t.date] << t
    end

    cast_to_date = ->(val) do
      return nil if val.nil?
      return val.to_date if val.respond_to?(:to_date)
      Date.parse(val.to_s) rescue nil
    end

    @habits.each do |habit|
      goal = habit.goal
      next unless goal.present?

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

      next if debut.nil? || fin.nil? || fin < debut

      range_start = [debut, visible_start].max
      range_end   = [fin,   visible_end].min

      (range_start..range_end).each do |day|
        @habits_by_date[day] << habit
      end
    end
  end

  def day
    begin
      @selected_date = Date.parse(params[:date]) rescue Date.today
      habits = current_user.habits.includes(:category, :goal)
      @habits_for_day = habits.select { |h| h.has_goal_for_date?(@selected_date) }
      @trackers_by_habit = Tracker
        .where(habit_id: @habits_for_day.map(&:id), date: @selected_date)
        .group_by(&:habit_id)

      respond_to do |format|
        format.turbo_stream
        format.html do
          render partial: "calendar/day_modal",
                locals: {
                  selected_date: @selected_date,
                  habits_for_day: @habits_for_day,
                  trackers_by_habit: @trackers_by_habit
                }
        end
      end
    rescue => e
      logger.error "[Calendar#day] #{e.class}: #{e.message}\n#{e.backtrace.first(10).join("\n")}"

      respond_to do |format|
        format.turbo_stream do
          render inline: <<~ERB.html_safe, status: 500
            <turbo-stream action="replace" target="dayModalContainer">
              <template>
                <div class="alert alert-danger">
                  Erreur interne (Calendar#day): #{ERB::Util.html_escape(e.class.to_s)} — #{ERB::Util.html_escape(e.message)}
                  <pre style="white-space:pre-wrap; max-height:200px; overflow:auto;">#{ERB::Util.html_escape(e.backtrace.first(10).join("\n"))}</pre>
                </div>
              </template>
            </turbo-stream>
          ERB
        end
        format.html { render plain: "Error: #{e.message}", status: 500 }
      end
    end
  end

end
