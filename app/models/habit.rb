class Habit < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one :goal
end
