require 'oystercard'

describe Oystercard do
  it 'fresh card has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up balance with amount in argument' do
      expect { subject.top_up(20) }.to change { subject.balance }.by (20)
    end
  end

end
