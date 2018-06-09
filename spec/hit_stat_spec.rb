describe HitStat do
  it 'has a batting average method' do
    expect(subject).to respond_to(:batting_average)
  end

  it 'has a slugging percent method' do
    expect(subject).to respond_to(:slugging_percentage)
  end
end
