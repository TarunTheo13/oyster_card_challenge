require 'Oystercard'

describe Oystercard do
  it 'has a starting balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'allows us to add money' do
    subject.top_up(10)
    subject.top_up(7)
    expect(subject.balance).to eq 17
  end
end