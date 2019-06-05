class Oystercard
  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Max balance allowed is £#{LIMIT}" if (@balance + amount) > LIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient balance" if @balance < MINIMUM
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM)
    @in_journey = false
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
