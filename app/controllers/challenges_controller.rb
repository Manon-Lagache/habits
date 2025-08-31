class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
  end
end
