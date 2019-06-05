require 'oystercard'

describe Oystercard do
  describe 'fresh card' do
    it 'has a balance of 0' do
      expect(subject.balance).to eq(0)
    end

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
    end

    before(:each) do
      subject.top_up(5)
      subject.touch_in(station)
    end

    describe '#touch_in' do
      it 'changes in journey to be true' do
        expect(subject).to be_in_journey
      end

      it 'remembers the entry station after touching in' do
        expect(subject.entry_station).to eq station
      end
    end

    describe '#touch_out' do
      it 'deducts fare from card balance when touch out' do
        expect { subject.touch_out }.to change { subject.balance }.by(-minimum)
      end

      it 'changes in journey to be false' do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
  end
end
