class Goal < ApplicationRecord
  belongs_to :habit

  validates :value, presence: true
  validates :frequency, presence: true
  validates :end_type, presence: true

  store_accessor :tracking_config, :weekly_days, :monthly_days, :monthly_count, :reminder
end
