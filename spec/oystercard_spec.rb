require 'oystercard'

describe Oystercard do
  subject(:oyster) { described_class.new }
  describe '#balance' do
    # context 'balance is 0' do
      it 'displays 0' do
        expect(oyster.balance).to eq 0
      end
    # end
      it 'tops up balance with given amount' do
        oyster.top_up(5)
        expect(oyster.balance).to eq 5
      end

      # removed this test as deduct method is now private
      # it 'deducts balance with given amount' do
      #   oyster.top_up(10)
      #   oyster.deduct(5)
      #   expect(oyster.balance).to eq 5
      # end

      it 'when touching out, minimum fare is deducted from balance' do
        oyster.top_up(5)
        oyster.touch_in
        oyster.touch_out
        expect(oyster.balance).to eq 4
      end

  end

  describe '#maximum_and_minimum_balance' do
    it 'throws an error if balance is greater than £90' do
      oyster.top_up(Oystercard::MAX_BALANCE)
      expect { oyster.top_up(1) }.to raise_error "Error: Cannot top up, balance exceeds Maximum Balance £#{Oystercard::MAX_BALANCE}"
    end

    it 'throws an error if balance is less than £1' do
      oyster.top_up(0.40)
      expect { oyster.touch_in }.to raise_error "Error: Cannot touch in, your balance is less than minimum balance £#{Oystercard::MIN_BALANCE}"
    end
  end

  describe '#in_journey?' do
    it 'it tells us if the user is currently on a journey' do
      expect(oyster.in_journey?).to eq false
    end

    it 'tells us if the user is currently touched in' do
      oyster.top_up(5) #min_balance step 9: added this line to pass min_balance test
      oyster.touch_in
      expect(oyster.in_journey?).to eq true
    end

    it 'tells us if the user is currently touched out' do
      oyster.touch_out
      expect(oyster.in_journey?).to eq false
    end

  end
end
