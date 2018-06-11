describe "Most Improved Batting Average" do
  context "HitStat returns Players with at least 200 appearances" do
    before do
      player1 = create(:player)
      player2 = create(:player)
      @inelig = create(:hit_stat, at_bats: 199, player: player1)
      @elig = create(:hit_stat, at_bats: 200, player: player2)
    end
    it 'doesnt return players under 200 appearances' do
      expect(HitStat.min_at_bats(200)).to_not include(@inelig)
    end
    it 'does return players over 200 at bats' do
      expect(HitStat.min_at_bats(200)).to include(@elig)
    end
  end

  context "averages by year" do
    before do
      @player = create(:player_w_stats)
      @player.hit_stats[0].update({hits: 20, year: 2008, at_bats: 200})
      @player.hit_stats[1].update({hits: 40, year: 2009, at_bats: 200})
      @player.hit_stats[2].update({hits: 80, year: 2010, at_bats: 200})
      @player.save!
    end
    it "returns zero if stats are missing" do
      player = build(:player)
      expect(player.year_difference(start_year: 2009)).
        to eq(0.0)
    end

    it "returns the numerical difference of the 2 years" do
      expect(@player.year_difference(start_year: 2008)).to eq(0.1)
      expect(@player.year_difference(start_year: 2009)).to eq(0.2)
    end

    it "returns the player with the biggest change for a year" do
      pws = create(:player_w_big_stats)
      expect(Player.count).to eq(2)
      expect(HitStat.most_improved_hitting(start_year: 2008)).to eq([@player, 0.1])
    end
  end
end
