require 'csv'
require_relative './application'

class HitStat < ApplicationModel

  belongs_to :player

  scope :average_elig, -> {where("at_bats >= 200")}

  def self.from_csv_data!(data)
    return nil unless data
    HitStat.create!(player_id: data['playerID'], year: data['yearID'], league: data['league'],
      team: data['teamID'], at_bats: data['AB'], games: data['G'], runs: data['R'],
      hits: data['H'], doubles: data['2B'], triples: data['3B'], home_runs: data['HR'])
  end

  def self.most_improved_hitting(start_year:)
    by_player = Hash.new([])
    best_average = 0
    best_player = nil
    playercount = average_elig.distinct(:player_id).count
    all_elig = average_elig.where(year: (start_year..(start_year+1))).order(:year)
    # group stats by player
    all_elig.each do |elig_stat|
      pid = elig_stat.player_id
      by_player[pid] = Array(by_player[pid]) << elig_stat
    end
    by_player.each do |pid, player_stats|
      if(best_player == nil || average_diff(player_stats) > best)
        best_player = player_stats[0].player
        best_average = average_diff(player_stats)
      end
    end
    [best_player, best_average]
  end

  def batting_average
    return (hits.to_f / at_bats).truncate(3)
  end

  def slugging_percentage
    ((hits - doubles - triples - home_runs) +
        (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f
  end

  private

  def self.average_diff(stats)
puts ">>>>#{stats.inspect}<<<<"
    return 0 unless stats && stats.count(2)
    return stats[1].batting_average - stats[0].batting_average
  end
end
