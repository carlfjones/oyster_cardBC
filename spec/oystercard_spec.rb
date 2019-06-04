require 'oystercard'

describe Oystercard do  
  it 'fresh card has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    limit = Oystercard::LIMIT
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up balance with amount in argument' do
      card = Oystercard.new
      card.top_up(10) 
      expect(card.balance).to eq(10)
      
    end

    it 'throws error if top up would exceed £#{limit}' do      
      expect { subject.top_up(91) }.to raise_error("Max balance allowed is £#{limit}")
    end
  end

end
