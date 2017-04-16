class Vote < ApplicationRecord
  belongs_to :player
  belongs_to :user

  scope :created_on, lambda {|date| where("date(created_at) = ?", date)}

  def self.player_votes_hash
    player_votes = Vote.created_on(Date.today).includes(:player).group_by(&:player).each_with_object({}) {|(player, votes), hash| hash[player] = votes}
    sorted_player_votes = player_votes.sort_by{|_k, votes| -votes.length}
    Hash[sorted_player_votes]
  end
end
