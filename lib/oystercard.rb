class Oystercard
  attr_reader :balance, :journey_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Error: Cannot top up, balance exceeds Maximum Balance £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    !!@journey_history[-1].value?(:unfinished)
  end

  def touch_in(station)
    raise "Error: Cannot touch in, your balance is less than minimum balance £#{MIN_BALANCE}" if @balance < MIN_BALANCE

    add_journey(station)
  end

  def touch_out(station)
    add_journey(station)
    deduct(MIN_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_journey(station)
    if @journey_history.empty? || !@journey_history[-1].value?(:unfinished)
      @journey_history << { entry_station: station, exit_station: :unfinished }
    else
      @journey_history[-1][:exit_station] = station

    end
  end
end
