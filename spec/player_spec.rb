describe Player do
  context 'database' do
    it 'can load players' do
      expect(Player.all).to eq([])
    end

    it 'can save a player' do
      expect(Player.count).to eq(0)
      expect {
        Player.create!(name: 'Bob', id: 'aaa1')
      }.to change {Player.count}.from(0).to(1)
    end
  end

  context 'with stats' do
      let(:player) { Player.create!(name: 'one', id: 'aaa1') }
      let(:stat) { HitStat.create!(player_id: 'aaa1', year: 2000, league: 'AL', team: 'AZ', at_bats: 6) }

    it 'can get the stats by player' do
      subject = Player.find('aaa1')
      subject.hit_stats.create!(year: 2000, league: 'AL', team: 'az', at_bats: 6)
      expect(subject.hit_stats).to include(stat)
    end
  end
end
