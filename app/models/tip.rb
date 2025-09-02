class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :habit

  validates :content, presence: true
  validates :tip_type, inclusion: { in: %w[long daily] }
end
