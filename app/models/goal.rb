class Goal < ApplicationRecord
  belongs_to :habit

  validates :value, presence: true
  validates :frequency, presence: true
  validates :end_type, presence: true

  store_accessor :tracking_config, :weekly_days, :monthly_days, :monthly_count, :reminder

  def period_display
    case end_type
    when "indefinite"
      "Indéfinie"
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

end