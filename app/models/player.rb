class Player < ApplicationRecord
  has_many :votes

  def self.full_ranking
    Rails.cache.fetch("#{Date.today}/full_ranking") do
      start_date = Vote.start_date
      ranking = []
      return ranking if start_date.nil?
      tally = {}
      (start_date...Date.today).each do |date|
        votes_on_date = Vote.created_on(date).includes(:player)
        next if votes_on_date.empty?
        votes_on_date.each do |vote|
          player = vote.player
          if tally[player]
            tally[player] << vote
          else
            tally[player] = [vote]
          end
        end
        top_player, _ = tally.max_by{|_player, votes| votes.length}
        ranking << top_player
        tally.delete(top_player)
      end
      ranking
    end
  end
end
