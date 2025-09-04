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

 def chart_data(goal_value)
   start_date = Date.today - 7.days
   end_date   = Date.today

   data_by_date = trackers.where("date >= ?", start_date)
                          .group("DATE(date)")
                          .sum(:value)

   real_data = (start_date..end_date).map { |date|
     [date.strftime("%d/%m"), data_by_date[date] || 0]
   }

   goal_data = (start_date..end_date).map { |date|
     [date.strftime("%d/%m"), goal_value]
   }

   [
    { name: "Progression", data: real_data, dataset: { type: "line", fill: true } }, # area = line avec fill
    { name: "Objectif", data: goal_data, dataset: { type: "line", fill: false, pointRadius: 0, pointHoverRadius: 0 } }
    ]
  end

  def cast_reminder_enabled
    self.reminder_enabled = ActiveModel::Type::Boolean.new.cast(reminder_enabled)
  end

  def has_goal_for_date?(date)
    goal.present? && goal.active_on_date?(date)
  end

  private

  def enqueue_llm_tip_job
    LlmTipJob.perform_later(self.id)
  end
end
