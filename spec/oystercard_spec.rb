require 'Oystercard'

describe Oystercard do
  it 'has a starting balance of zero' do
    expect(subject.balance).to eq 0
  end
end