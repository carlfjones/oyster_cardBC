require_relative 'Station'

class Oystercard
  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    #@in_journey = false
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Max balance allowed is £#{LIMIT}" if (@balance + amount) > LIMIT
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MINIMUM
    #@in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    #@in_journey = false
    @journeys << {in_station: @entry_station, out_station: station}
    deduct(MINIMUM)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
