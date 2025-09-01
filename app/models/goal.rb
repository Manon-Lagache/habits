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
end
