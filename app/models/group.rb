class Group < ApplicationRecord
  belongs_to :challenge
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships
end
