require 'csv'
require_relative './application'

class HitStat < ApplicationModel

  belongs_to :player

  scope :average_elig, -> {where("at_bats > 200")}

  def batting_average
    hits / at_bats
  end
end
