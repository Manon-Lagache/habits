class Verb < ApplicationRecord
  has_many :habit_types, through: :habits
  has_many :habits
end
