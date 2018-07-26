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
  it { is_expected.to have_property(:billing_address) }
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

  describe "card_network" do
    let(:credit_card_visa) { Cashbox::PaymentMethod.new(type: "CreditCard", credit_card: { bin: "3210" }) }
    let(:credit_card_master_card) { Cashbox::PaymentMethod.new(type: "CreditCard", credit_card: { bin: "2345" }) }
    let(:credit_card_master_card_two) { Cashbox::PaymentMethod.new(type: "CreditCard", credit_card: { bin: "5432" }) }
    let(:credit_card_unknown) { Cashbox::PaymentMethod.new(type: "CreditCard", credit_card: { bin: "9999" }) }
    let(:direct_debit) { Cashbox::PaymentMethod.new(type: "DirectDebit", direct_debit: {}) }

    it "returns the correct card networks" do
      expect(credit_card_visa.card_network).to eq("Visa")
      expect(credit_card_master_card.card_network).to eq("Master Card")
      expect(credit_card_master_card_two.card_network).to eq("Master Card")
      expect(credit_card_unknown.card_network).to eq("unknown network")
      expect(direct_debit.card_network).to eq("not a card")
    end
  end
end
