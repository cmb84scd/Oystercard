require 'oystercard'

describe Oystercard do
  it 'Has a initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'lets you top up card' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it 'throws an error if maximum balance reached' do
    max_balance = Oystercard::MAX_BALANCE
    subject.top_up(max_balance)
    expect{ subject.top_up 1 }.to raise_error("Max balance reached: #{max_balance}")
  end

  it 'lets you deduct from card' do
    expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
  end

  it 'lets you touch in' do
    expect(subject).to respond_to(:touch_in)
  end

  it 'know when your on a journey' do
    expect(subject.in_journey?).to eq true
  end

  it 'lets you touch out' do
    expect(subject).to respond_to(:touch_out)
  end

end
