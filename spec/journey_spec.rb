require 'journey'

describe Journey do

  describe 'Initialize attributes' do

  let(:station){ double :station }

    it 'initializes with entry station' do
        journey = Journey.new(station)
      expect(journey.entry_station).to eq station
    end

    it 'initializes with empty exit station' do
        journey = Journey.new(station)
      expect(journey.exit_station).to eq nil
    end

    it 'initializes with a incomplete journey' do
        journey = Journey.new(station)
      expect(journey.complete).to eq false
    end

    it 'initializes with a penatly fare' do
        journey = Journey.new(station)
      expect(journey.fare).to eq Journey::PENALTYFARE
    end
  end

    describe 'Finishes journey' do

      let(:station){ double :station }

      it 'changes exit station to station' do
        journey = Journey.new(station)
        journey.finish_journey(station)
        expect(journey.exit_station).to eq station
      end

      it 'changes journey to complete' do
        journey = Journey.new(station)
        journey.finish_journey(station)
        expect(journey.complete).to eq true
      end

      it 'charges minumum fare' do
        journey = Journey.new(station)
        journey.finish_journey(station)
        expect(journey.fare).to eq Journey::MINIMUM
      end

    end
end
