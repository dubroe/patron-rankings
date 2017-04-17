class VotesController < ApplicationController
  def create
    vote = current_user.current_or_new_vote
    vote.player_id = params[:vote][:player_id]
    vote.save!
    redirect_to :root
  end
end
