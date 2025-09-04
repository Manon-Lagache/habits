class Goal < ApplicationRecord
  belongs_to :habit

  validates :value, presence: true
  validates :frequency, presence: true
  validates :end_type, presence: true

  store_accessor :tracking_config, :weekly_days, :monthly_days, :monthly_count, :reminder

  def translate_frequency
    case self.frequency
    when "daily"
      "par jour"
    when "weekly"
      "par semaine"
    when "monthly"
      "par mois"
    end
  end

  def period_display
    case end_type
    when "indefinite"
      "Période permanente"
    when "target_day"
      "Jusqu'au #{target_day&.strftime("%d/%m/%Y")}"
    when "period"
      "Du #{start_date&.strftime("%d/%m/%Y")} au #{end_date&.strftime("%d/%m/%Y")}"
    else
      "Période inconnue"
    end
  end

  def active_dates
    return [] unless habit.present?

    start_d = start_date.presence || habit.created_at.to_date

    end_d = case end_type
            when "period"
              end_date.presence || start_d
            when "target_date"
              target_day.presence || start_d
            when "indefinite"
              start_d + 5.years
            else
              start_d
            end

    (start_d..end_d).to_a
  end

  def active_on_date?(date)
    case self.end_type
    when "period"
      date <= end_date && date >= start_date
    when "target_date", "target_day"
      date <= target_day && date >= habit.created_at.to_date
    when "indefinite"
      date >= habit.created_at.to_date
    else
      false
    end
  end

end
