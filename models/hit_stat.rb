require 'csv'
require_relative './application'

class HitStat < ApplicationModel

  belongs_to :player

  scope :average_elig, -> {where("at_bats > 200")}

  def batting_average
    return (hits.to_f / at_bats).truncate(3)
  end

  def slugging_percentage
    ((hits - doubles - triples - home_runs) +
        (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f
  end
end
