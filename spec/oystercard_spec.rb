require 'oystercard'

describe Oystercard do

  describe 'fresh card' do

    it 'tests that journeys is empty when initialized' do
      expect(subject.journeys).to eq([])
    end

    it 'has a balance of 0' do
      expect(subject.balance).to eq(0)
    end

    # I think this is still relevant because of the !! against the entry_station variable in the in_journey method

    it 'is not in_journey' do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#top_up' do

    limit = Oystercard::LIMIT

    it 'tops up balance with amount in argument' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'throws error if top up would exceed £#{limit}' do
      expect { subject.top_up(91) }.to raise_error("Max balance allowed is £#{limit}")
    end
  end

  # describe '#deduct' do
  #   it 'deducts fare from card balance' do
  #     subject.top_up(90)
  #     expect { subject.deduct(50) }.to change { subject.balance }.by(-50)
  #   end
  # end

  describe 'on journey' do

    let(:station){ double :station }

    minimum = Oystercard::MINIMUM

    describe '#touch_in' do

      it 'throws error if card has insufficient balance' do
        expect{ subject.touch_in }.to raise_error('Insufficient balance') if subject.balance < minimum
      end

      before(:each) do
        subject.top_up(5)
        subject.touch_in(station)
      end

      # do we still need this test as we no longer have the in_journey variable?
      # should we update to test the entry_station variable?
      # or is it still working and linking to the in_journey? method?

      it 'changes in journey to be true' do
        expect(subject).to be_in_journey
      end

    end

    describe '#touch_out' do

      it 'deducts fare from card balance when touch out' do
        expect { subject.touch_out(station) }.to change { subject.balance }.by(-minimum)
      end

      # do we still need this test as we no longer have the in_journey variable?
      # should we update to test the entry_station variable?
      # or is it still working and linking to the in_journey? method?
      it 'changes in journey to be false' do
        subject.touch_out(station)
        expect(subject).not_to be_in_journey
      end

      it 'stores a journey instance' do
        subject.top_up(20)
        subject.touch_in(station)
        subject.touch_out(station)
      end
    end
  end
end
