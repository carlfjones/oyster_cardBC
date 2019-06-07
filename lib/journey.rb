

class Journey
    PENALTYFARE = 6
    MINIMUM = 1
  attr_reader :entry_station, :exit_station, :complete, :fare

  def initialize(station)
    @entry_station = station
    @exit_station = nil
    @complete = false
    @fare = PENALTYFARE
  end


  def finish_journey(station)
    @exit_station = station
    @complete = true
    @fare = MINIMUM
  end

end
