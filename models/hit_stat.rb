require 'csv'
require_relative './application'

class HitStat < ApplicationModel

  belongs_to :player, foreign_key: 'player_id', primary_key: 'player_id'

  scope :min_at_bats, -> (abs) {where("at_bats >= ?", abs)}
  scope :year, ->(year) {where(year: year)}
  scope :team, ->(team) {where(team: team)}

  def self.from_csv_data!(data)
    return nil unless data
    HitStat.create!(player_id: data['playerID'], year: data['yearID'], league: data['league'],
      team: data['teamID'], at_bats: data['AB'], games: data['G'], runs: data['R'],
      hits: data['H'], doubles: data['2B'], triples: data['3B'], home_runs: data['HR'],
      rbi: data['RBI'])
  end

  def batting_average
    return 0 unless hits.to_i > 0 && at_bats.to_i > 0
    return (hits.to_f / at_bats).truncate(3)
  end

  def slugging_percentage
    return 0 unless hits && doubles && triples && home_runs && at_bats && at_bats > 0
    ((hits - doubles - triples - home_runs) +
        (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f
  end
end
