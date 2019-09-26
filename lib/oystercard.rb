class Oystercard
  attr_reader :balance, :journey_history, :on_journey
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @on_journey = nil
  end

  def top_up(amount)
    raise "Error: Cannot top up, balance exceeds Maximum Balance £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE

    @balance += amount
  end
    
  def in_journey?
    @on_journey
  end

  def touch_in(station)
    raise "Error: Cannot touch in, your balance is less than minimum balance £#{MIN_BALANCE}" if @balance < MIN_BALANCE
    raise 'Already in journey' if in_journey?
    @on_journey = true
    add_journey(station)
  end

  def touch_out(station)
    raise 'not in journey' unless in_journey?
    @on_journey = false
    add_journey(station)
    deduct(MIN_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  # def add_journey(station)
  #   if on_journey == true
  #     @journey_history << { entry_station: station, exit_station: :unfinished }
  #   else
  #     @journey_history[-1][:exit_station] = station

  #   end
  # end
end
