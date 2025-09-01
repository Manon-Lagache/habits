class Habit < ApplicationRecord
  before_save :cast_reminder_enabled

  belongs_to :user
  belongs_to :category
  belongs_to :habit_type
  belongs_to :verb

  has_one :goal, dependent: :destroy
  has_many :trackers, dependent: :destroy
  has_many :tips, dependent: :destroy

  accepts_nested_attributes_for :goal

  validates :name, presence: true
  validates :verb, presence: true
  validates :category, presence: true
  validates :habit_type, presence: true
  validates :visibility, inclusion: { in: %w[private public friends] }

  def chart_data
    start_date = Date.today - 7.days
    end_date = Date.today

    data_by_date = trackers.where("date >= ?", start_date)
                           .group("DATE(date)")
                           .sum(:value)

    (start_date..end_date).map do |date|
      [
        date.strftime("%Y-%m-%d"),
        data_by_date[date] || 0
      ]
    end
  end

  def cast_reminder_enabled
    self.reminder_enabled = ActiveModel::Type::Boolean.new.cast(reminder_enabled)
  end
end
