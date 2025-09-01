class Challenge < ApplicationRecord
  belongs_to :user
  has_one :group, dependent: :destroy

  def creator
    user.avatar
  end
end
