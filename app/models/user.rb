class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :habits, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  def available_challenges
    participated_challenge_ids = groups.joins(:challenge).pluck('challenges.id')
    Challenge.where.not(id: participated_challenge_ids)
  end
end
