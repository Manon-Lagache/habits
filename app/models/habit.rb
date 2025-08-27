class Habit < ApplicationRecord
  belongs_to :user

  belongs_to :category
  has_one :goal
  belongs_to :habit_type
  has_many :goals, dependent: :destroy
  has_many :trackers, dependent: :destroy
  has_many :tips, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :habit_type, presence: true
  validates :visibility, inclusion: { in: %w[private public friends] }

end
