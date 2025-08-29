class Verb < ApplicationRecord
  has_and_belongs_to_many :habit_types
  has_many :habits
end