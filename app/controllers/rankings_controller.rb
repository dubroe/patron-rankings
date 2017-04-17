class RankingsController < ApplicationController
  def index
    return if current_user.nil?
    @ranked_players = Player.full_ranking
    @available_players = Player.all - @ranked_players
    @active_grouped_votes = Vote.active_grouped
    @current_vote = current_user.current_vote
  end
end
