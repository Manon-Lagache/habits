class Habit < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :habit_type

  has_one :goal, dependent: :destroy
  has_many :trackers, dependent: :destroy
  has_many :tips, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :habit_type, presence: true
  validates :visibility, inclusion: { in: %w[private public friends] }

  serialize :goal, JSON

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
end
