class Habit < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :category, presence: true
  validates :habit_type, presence: true
  validates :visibility, inclusion: { in: %w[private public friends] }
end
