FactoryBot.define do
  factory :player do
    sequence(:name) {|n| "#{n} Big Poppi" }
    sequence(:player_id) {|n| "aaa#{n}"}

    factory :player_w_stats do
      after(:create) do |player, evaluator|
        create_list(:hit_stat, 4, player: player)
      end
    end
    
  end


  factory :hit_stat do
    association :player, factory: :player
    sequence(:year, 2008)
    league 'AL'
    team 'COL'
    at_bats 100
    games 44
    runs 22
    hits 20
    doubles 6
    triples 2
    home_runs 11
  end
end
