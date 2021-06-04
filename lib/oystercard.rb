class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @counter = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Minimum balance required: £1' if @balance < MINIMUM_FARE
    @entry_station = station
    @journeys << {entry_station: station}
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @journeys[@counter][:exit_station] = station
    @counter += 1
  end

  def in_journey?
    !!entry_station
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end

end
