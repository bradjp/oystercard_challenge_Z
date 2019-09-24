class Oystercard

  attr_reader :balance, :in_journey
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    # @balance = @balance + amount
    raise "Error: Cannot top up, balance exceeds Maximum Balance £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance = @balance + amount
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
  # def balance
  #   @balance
  # end

end
