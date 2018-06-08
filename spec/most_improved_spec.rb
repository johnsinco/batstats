describe "Most Improved Batting Average" do
  context "HitStat returns Players with at least 200 appearances" do
    let(:players) { [create(:player), create(:player)] }
    before do
      @inelig = create(:hit_stat, at_bats: 199)
      @elig = create(:hit_stat, at_bats: 200)
    end
    it 'doesnt return players under 200 appearances' do
      expect(HitStat.average_elig).to_not include(@inelig)
    end
    it 'does return players over 200 at bats' do
      expect(HitStat.average_elig).to_not include(@elig)
    end
  end

  context "averages by year" do
    it "returns zero if stats are missing" do
      player = build(:player)
      expect(player.year_difference(start_year: 2009)).
        to eq(0.0)
    end

    it "returns the numerical difference of the 2 years" do
      player = create(:player)
      player.hit_stats << build(:hit_stat, year: 2008, hits: 20)
      player.hit_stats << build(:hit_stat, year: 2009, hits: 40)
      player.save!
      expect(player.hit_stats.count).to eq(2)
      expect(player.year_difference(start_year: 2008)).
        to eq(0.5)
    end
  end
end
