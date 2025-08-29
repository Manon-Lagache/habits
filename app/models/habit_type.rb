class HabitType < ApplicationRecord
  belongs_to :category

  validates :unit, presence: true
  validates :name, presence: true
end
