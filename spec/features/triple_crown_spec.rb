describe "Triple Crown Winner" do
  it "returns a single player who won the crown stat or nil if no winner" do
    juicer = create(:juiced_player)
    create(:hit_stat)
    expect(Player.count).to eq(2)
    expect(HitStat.count).to eq(3)
    expect(HitStat.triple_crown_winner(year: 2008, league: 'AL')).to eq(juicer)
  end

  it "returns nil if there's no single winner" do
      create(:big_stat, year: 2008, league: 'AL')
      create(:hit_stat, year: 2008, league: 'AL')
      expect(HitStat.count).to eq(2)
      expect(Player.count).to eq(2)
      expect(HitStat.triple_crown_winner(year: 2008, league: 'AL'))
  end
end
