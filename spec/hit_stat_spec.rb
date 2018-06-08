describe HitStat do
  it 'has a batting average method' do
    subject = build(:hit_stat)
    expect(subject).to respond_to(:batting_average)
  end
end
