class Goal < ApplicationRecord
  belongs_to :habit
  has_one :program, dependent: :destroy
  has_many :groups
end
