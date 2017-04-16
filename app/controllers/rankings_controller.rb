class RankingsController < ApplicationController
  def index
    return if current_user.nil?
    @current_vote = current_user.todays_vote
  end
end
