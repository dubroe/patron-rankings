class VotesController < ApplicationController
  def create
    vote = current_user.todays_vote || current_user.votes.build
    vote.player_id = params[:vote][:player_id]
    vote.save!
    redirect_to :root
  end
end
