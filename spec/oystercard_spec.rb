require 'oystercard'

describe Oystercard do
  subject(:oyster) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

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
        oyster.touch_in(entry_station)
        oyster.touch_out(exit_station)
        expect(oyster.balance).to eq 4
      end

  end

  describe '#top_up' do
    it 'throws an error if balance is greater than £90' do
      oyster.top_up(Oystercard::MAX_BALANCE)
      expect { oyster.top_up(1) }.to raise_error "Error: Cannot top up, balance exceeds Maximum Balance £#{Oystercard::MAX_BALANCE}"
    end
  end

  describe '#touch_in' do
    it 'throws an error if balance is less than £1' do
      oyster.top_up(0.40)
      expect { oyster.touch_in(entry_station) }.to raise_error "Error: Cannot touch in, your balance is less than minimum balance £#{Oystercard::MIN_BALANCE}"
    end

    it 'tells us if the user is currently touched in' do
      oyster.top_up(5) #min_balance step 9: added this line to pass min_balance test
      oyster.touch_in(entry_station)
      expect(oyster.in_journey?).to eq true
    end

    it 'records entry station' do
      oyster.top_up(5)
      oyster.touch_in(entry_station)
      expect(oyster.entry_station).to eq entry_station
    end

  end

  describe '#touch_out' do
    it 'tells us if the user is currently touched out' do
      oyster.touch_out(exit_station)
      expect(oyster.in_journey?).to eq false
    end

    it 'forgets entry station' do
      oyster.top_up(5)
      oyster.touch_in(entry_station)
      oyster.touch_out(exit_station)
      expect(oyster.entry_station).to eq nil
    end

    it 'stores an exit station' do
      oyster.top_up(5)
      oyster.touch_in(entry_station)
      oyster.touch_out(exit_station)
      expect(oyster.exit_station).to eq exit_station
    end
  end

  describe 'journeys' do
    it 'should have an empty journey list by default' do
      expect(oyster.journey_history).to eq []
    end

    it 'checks that touching in and out stores a journey' do
      oyster.top_up(5)
      oyster.touch_in(entry_station)
      oyster.touch_out(exit_station)
      expect(oyster.journey_history).to eq [{ entry_station: entry_station, exit_station: exit_station }]
    end
  end

  #
  # describe '#in_journey?' do
  #   it 'it tells us if a new  is currently on a journey' do
  #     expect(oyster.in_journey?).to eq false
  #   end
  # end

end
