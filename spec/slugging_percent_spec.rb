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
end
