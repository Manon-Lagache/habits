class Habit < ApplicationRecord
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

end
