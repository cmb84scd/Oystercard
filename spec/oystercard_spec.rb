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

      describe 'lets you touch in' do
        specify { expect(subject.touch_in).to be_truthy }
      end

      it 'deducts money from card' do
        min_charge = Oystercard::MIN_CHARGE
        expect {subject.touch_out }.to change{ subject.balance }.by -min_charge
      end
    end
  end

  context 'it has low or no balance' do
    before(:all) do
      subject.top_up(Oystercard::MIN_CHARGE)

      it 'throws an error if isufficient funds' do
        min_charge = Oystercard::MIN_CHARGE
        expect{ subject.touch_in }.to raise_error("Insufficient funds")
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
