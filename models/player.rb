class Player < ApplicationModel
  has_many :hit_stats

  def year_difference(start_year:)
    stats = hit_stats.where(year: [start_year..(start_year+1)])
    return 0 unless stats.length == 2
    yr1, yr2 = stats.map {|stat| stat.batting_average}
    (yr2 - yr1).truncate(3)
  end

end
