require 'oystercard'

describe Oystercard do
  it 'fresh card has a balance of 0' do
    expect(subject.balance).to eq(0)
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

  describe '#deduct' do
    it 'deducts fare from card balance' do
      subject.top_up(90)
      expect { subject.deduct(50) }.to change { subject.balance }.by(-50)
    end

  end


end
