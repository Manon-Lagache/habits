class Challenge < ApplicationRecord
  belongs_to :user
  has_one :group, dependent: :destroy
end
