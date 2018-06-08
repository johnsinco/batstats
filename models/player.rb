class Player < ApplicationModel
  has_many :hit_stats

  def year_difference(start_year:)
    stats = hit_stats.where(year: [start_year..(start_year+1)])
puts stats.inspect
    yr1, yr2 = stats.map {|stat| stat.batting_average}
    (yr2 - yr1)
  end

end
