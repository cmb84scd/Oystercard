class Oystercard

MAX_BALANCE = 90
attr_reader :balance

def initialize
  @balance = 0
  @in_use = false
end

def top_up(amount)
  fail "Max balance reached: #{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
  @balance += amount
end

def deduct(amount)
  @balance -= amount
end

def touch_in
  @in_use = true
end

def in_journey?
  @in_use
end

def touch_out
  @in_use = false
end

end
