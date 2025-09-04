class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :habits, dependent: :destroy
  has_many :goals, through: :habits, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :challenges, dependent: :destroy

  def available_challenges
    participated_challenge_ids = groups.joins(:challenge).pluck('challenges.id')
    Challenge.where.not(id: participated_challenge_ids)
  end

  def unavailable_challenges
    participated_challenge_ids = groups.joins(:challenge).pluck('challenges.id')
    Challenge.where(id: participated_challenge_ids)
  end

  def display_challenges
    unavailable_challenges
  end

  def gain_xp!(amount = 60)
    self.xp_reward += amount
    save!
  end

  def xp_progress_percentage(max_xp = 500)
    if xp_reward >= max_xp
      100
    else
      (xp_reward * 100 /max_xp).round(1)
    end
  end
end
