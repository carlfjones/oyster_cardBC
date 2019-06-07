require_relative 'Station'
require_relative 'journey'

class Oystercard
  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    #@in_journey = false
    # @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Max balance allowed is £#{LIMIT}" if (@balance + amount) > LIMIT
    @balance += amount
  end

  def in_journey?
    return false if @journeys.empty?
    !@journey.complete
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MINIMUM
    @journey = Journey.new(station)
    # @entry_station = station
  end

  def touch_out(station)
    @journey.finish_journey(station)
    @journeys << @journey
    deduct(@journey.fare)
    # @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
