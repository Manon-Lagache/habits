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
end
