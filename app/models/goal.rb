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
      "Indéfinie"
    when "target_day"
      "Jusqu'au #{target_day&.strftime("%d/%m/%Y")}"
    when "period"
      "Du #{start_date&.strftime("%d/%m/%Y")} au #{end_date&.strftime("%d/%m/%Y")}"
    else
      "Période inconnue"
    end
  end
end
