class Player < ApplicationModel
  self.primary_key = 'player_id'
  has_many :hit_stats, primary_key: 'player_id', foreign_key: 'player_id'

  def self.from_csv_data!(data)
    return nil unless data
    Player.create!(player_id: data['playerID'],
      name: "#{data['nameFirst']} #{data['nameLast']}")
  end
end
