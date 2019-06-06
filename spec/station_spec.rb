require 'station'

describe Station do

  describe '@name' do
    station = Station.new("Paddington", 1)
    it 'is initialized with a name' do
      expect(station.name).to eq "Paddington"
    end
  end

  describe '@zone' do
    it 'is initialized with a zone' do
      station = Station.new("Paddington", 1)
      expect(station.zone).to eq 1
    end
  end

end
