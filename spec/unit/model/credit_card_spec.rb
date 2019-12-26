require 'spec_helper'

describe Cashbox::CreditCard do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:account) }
  it { is_expected.to have_property(:account_length) }
  it { is_expected.to have_property(:bin) }
  it { is_expected.to have_property(:expiration_date) }
  it { is_expected.to have_property(:last_digits) }

  its(:object) { is_expected.to eql('CreditCard') }

  describe '#network' do
    it 'returns visa when the visa prefix is sent' do
      credit_card = Cashbox::CreditCard.new({ bin: 4321 })
      expect(credit_card.network).to eql('Visa')
    end

    it 'returns master card when the master card prefix 2 is sent' do
      credit_card = Cashbox::CreditCard.new({ bin: 234 })
      expect(credit_card.network).to eql('MasterCard')
    end

    it 'returns master card when the master card prefix 5 is sent' do
      credit_card = Cashbox::CreditCard.new({ bin: 534 })
      expect(credit_card.network).to eql('MasterCard')
    end

    it 'returns Discover when the Discover prefix 6 is sent' do
      credit_card = Cashbox::CreditCard.new({ bin: 634 })
      expect(credit_card.network).to eql('Discover')
    end
  end
end
