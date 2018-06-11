describe "Slugging Percentage" do
  it "returns calculated slugging percent" do
    subject = create(:hit_stat,
      hits: 10,
      doubles: 2,
      triples: 2,
      home_runs: 2
    )
    # should be (10-2-2-2) + (4 + 6 + 8) / 10
    expect(subject.slugging_percentage).to eq(0.22)
  end

  it "can return data by year and team" do
    player = create(:big_stat, team: 'COL', year: 2008)
    expect(Stats.slugging_percentage(year: 2008, team: 'COL')).
      to eq([["Big Poppi", 4.43]])
  end
end
