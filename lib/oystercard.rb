class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail 'Maximum balance exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    fail 'Minimum balance required: £1' if @balance < MINIMUM_FARE
    @status = true
  end

  def touch_out
    @status = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @status
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end

end
