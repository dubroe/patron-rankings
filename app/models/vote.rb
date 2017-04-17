class Vote < ApplicationRecord
  belongs_to :player
  belongs_to :user

  scope :created_on, lambda {|date| where("date(created_at) = ?", date)}
  scope :active, -> {where.not(player_id: Player.full_ranking.map(&:id))}

  def self.active_grouped
    grouped_hash = Vote.active.includes(:player).group_by(&:player).each_with_object({}) {|(player, votes), hash| hash[player] = votes}
    Hash[grouped_hash.sort_by{|_k, votes| -votes.length}]
  end

  def self.start_date
    first_vote = Vote.order(:created_at).first
    first_vote.present? ? first_vote.created_at.to_date : nil
  end
end
