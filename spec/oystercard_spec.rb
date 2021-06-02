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

  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance exceeded'
  end

end