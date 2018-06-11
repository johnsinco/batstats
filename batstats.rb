#!/usr/bin/env ruby

require_relative 'app'
# load the database
require_relative 'lib/load_data'

# print the Stats

puts "\n\n"
puts "MOST IMPROVED BATTING AVERAGE 2009-2010"
mvp = Stats.most_improved_hitting(start_year: 2009)
puts "   #{mvp[0].name} : #{mvp[1]}"
puts "    "
puts "SLUGGING PERCENTAGE OAKLAND A's 2007"
Stats.slugging_percentage(year: 2007, team: 'OAK').each do |name, stat|
  puts "   #{name} : #{stat.truncate(3) || 0}"
end
puts "    "
puts "2011 Triple Crown Winners"
puts "  #{Stats.triple_crown_winner(year: 2011, league: 'AL')}"
puts "  #{Stats.triple_crown_winner(year: 2011, league: 'NL')}"
puts "2012 Triple Crown Winners"
puts "  #{Stats.triple_crown_winner(year: 2012, league: 'AL')}"
puts "  #{Stats.triple_crown_winner(year: 2012, league: 'NL')}"
