module Stats

  def self.triple_crown_winner(year:, league:)
    stats = HitStat.min_at_bats(400).year(year).where("league = ?", league)
    best_bat = stats.max_by { |s| s.batting_average || 0 }
    most_hr = stats.max_by { |s| s.home_runs || 0 }
    most_rbi = stats.max_by { |s| s.rbi || 0 }
    if best_bat && [best_bat, most_hr, most_rbi].uniq == [best_bat]
      return best_bat.player.name
    else
      return 'none'
    end
  end

  def self.most_improved_hitting(start_year:)
    best_average = 0
    best_player = nil

    all_elig = Player.joins(:hit_stats).merge(HitStat.min_at_bats(200))

    all_elig.each do |player|
      improve = average_diff(
        player.hit_stats.where(year: (start_year..(start_year+1))).order(:year)
      )
      if improve >= best_average
        best_average = improve
        best_player = player
      end
    end
    [best_player, best_average]
  end

  def self.slugging_percentage(year:, team:)
    HitStat.year(year).team(team).map {|stat| [stat.player.name, stat.slugging_percentage]}
  end

  private

  def self.average_diff(stats)
    return 0 unless stats && stats.count == 2
    sorted_stats = stats.sort_by {|stat| stat.year}
    return sorted_stats[1].batting_average - sorted_stats[0].batting_average
  end
end
