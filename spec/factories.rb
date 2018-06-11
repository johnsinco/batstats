FactoryBot.define do
  factory :player do
    # sequence(:name) {|n| "#{n} Big Poppi" }
    name 'Big Poppi'
    sequence(:player_id) {|n| "aaa#{n}"}

    factory :player_w_stats do
      after(:create) do |player, evaluator|
        create_list(:hit_stat, 4, player: player)
      end
    end

    factory :player_w_big_stats do
      after(:create) do |player, evaluator|
        create_list(:big_stat, 4, player: player)
      end
    end

    factory :juiced_player do
      name 'AROD'
      after(:create) do |player, evaluator|
        create_list(:arod, 2, player: player)
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

    factory :big_stat do
      hits 400
    end

    factory :arod do
      hits 500
      home_runs 100
      rbi 300
      year 2008
      league 'AL'
    end
  end
end
