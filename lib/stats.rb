module Stats

  def self.triple_crown_winner(year:, league:)
    stats = HitStat.year(year).where("league = ?", league)
    best_bat = stats.max_by { |s| s.batting_average }
    most_hr = stats.max_by { |s| s.home_runs }
    most_rbi = stats.max_by { |s| s.rbi }
    if best_bat && [best_bat, most_hr, most_rbi].uniq == [best_bat]
      return best_bat.player
    else
      return nil
    end
  end

  def self.most_improved_hitting(start_year:)
    by_player = Hash.new([])
    best_average = 0
    best_player = nil
    all_elig = HitStat.min_at_bats(200).where(year: (start_year..(start_year+1))).order(:year)
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

  private
  
  def self.average_diff(stats)
    return 0 unless stats && stats.count(2)
    return stats[1].batting_average - stats[0].batting_average
  end
end
