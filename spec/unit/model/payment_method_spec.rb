require 'spec_helper'

describe Cashbox::PaymentMethod do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }
  it { is_expected.to be_a(Cashbox::Rest::Archive) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:credit_card).coercing_with(Cashbox::CreditCard) }
  it { is_expected.to have_property(:direct_debit).coercing_with(Cashbox::DirectDebit) }
  it { is_expected.to have_property(:paypal).coercing_with(Cashbox::PayPal) }
  it { is_expected.to have_property(:primary) }
  it { is_expected.to have_property(:active) }
  it { is_expected.to have_property(:type) }
  it { is_expected.to have_property(:account_holder) }
  it { is_expected.to have_property(:billing_address).coercing_with(Cashbox::Address) }
  it { is_expected.to have_property(:validation_status) }

  its(:object) { is_expected.to eql('PaymentMethod') }

  describe "credit_card?" do
    let(:payment_method_credit_card) { Cashbox::PaymentMethod.new(type: "CreditCard") }
    let(:payment_method_direct_debit) { Cashbox::PaymentMethod.new(type: "DirectDebit") }

    it "returns true for type credit card when asking if credit_card" do
      expect(payment_method_credit_card.credit_card?).to be(true)
    end

    it "returns false for type direct debit when asking if credit_card" do
      expect(payment_method_direct_debit.credit_card?).to be(false)
    end
  end

  describe "direct_debit?" do
    let(:payment_method_credit_card) { Cashbox::PaymentMethod.new(type: "CreditCard") }
    let(:payment_method_direct_debit) { Cashbox::PaymentMethod.new(type: "DirectDebit") }

    it "returns true for type direct debit when asking if direct debit" do
      expect(payment_method_direct_debit.direct_debit?).to be(true)
    end

    it "returns false for type credit card when asking if direct_debit" do
      expect(payment_method_credit_card.direct_debit?).to be(false)
    end
  end

  describe "last_digits" do
    params = { last_digits: "1234" }
    let(:payment_method_credit_card) { Cashbox::PaymentMethod.new(type: "CreditCard", credit_card: params) }
    let(:payment_method_direct_debit) { Cashbox::PaymentMethod.new(type: "DirectDebit", direct_debit: params) }

    it "returns the last digits for credit_card" do
      expect(payment_method_credit_card.last_digits).to eq("1234")
    end

    it "returns the last digits for direct_debit" do
      expect(payment_method_direct_debit.last_digits).to eq("1234")
    end
  end

  describe "#card_network" do
    context 'with a credit card' do
      let(:credit_card) { Cashbox::CreditCard.new({ }) }

      subject do
        Cashbox::PaymentMethod.new({
          type: Cashbox::PaymentMethod::CREDIT_CARD,
          credit_card: credit_card
        })
      end

      it 'delegates to credit card for the network name' do
        allow(credit_card).to receive(:network).and_return('Visa')
        subject.card_network
        expect(credit_card).to have_received(:network)
      end
    end

    context 'with a direct debit' do
      subject do
        Cashbox::PaymentMethod.new({
          type: Cashbox::PaymentMethod::DIRECT_DEBIT,
          direct_debit: Cashbox::DirectDebit.new({ })
        })
      end

      it 'does not delegate to direct debit' do
        expect(subject.card_network).to be_nil
      end
    end
  end
end
