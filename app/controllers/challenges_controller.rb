class ChallengesController < ApplicationController
  def index
    @challenges = current_user.available_challenges
  end
end
