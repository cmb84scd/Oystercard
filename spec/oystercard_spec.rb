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

  context 'it has a balance' do
    before(:all) do
      subject.top_up(Oystercard::MAX_BALANCE)

      it 'lets you deduct from card' do
        expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
      end

      describe 'lets you touch in' do
        specify { expect(subject.touch_in).to be_truthy }
      end
    end
  end

  describe 'in_journey?' do
    specify { expect(subject.in_journey?).not_to be_truthy }
  end

  describe 'lets you touch out' do
    specify { expect(subject.touch_out).not_to be_truthy }
  end

end
