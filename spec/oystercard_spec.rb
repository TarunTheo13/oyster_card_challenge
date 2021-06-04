require 'Oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

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
    expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'is initially not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'raises an error if below minimum balance when touching in' do
    expect {subject.touch_in(entry_station) }.to raise_error 'Minimum balance required: £1'
  end

  it 'deducts money from balance when tapping out' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'stores a journey' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

end
