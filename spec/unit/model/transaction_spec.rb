require 'spec_helper'

describe Cashbox::Transaction do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }
  it { is_expected.to be_a(Cashbox::Rest::Cancel) }
  it { is_expected.to be_a(Cashbox::Rest::Refund) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:account).coercing_with(Cashbox::Account) }
  it { is_expected.to have_property(:affiliate) }
  it { is_expected.to have_property(:amount).coercing_with(Float) }
  it { is_expected.to have_property(:billing_attempt).coercing_with(Integer) }
  it { is_expected.to have_property(:billing_descriptor) }
  it { is_expected.to have_property(:billing_plan_sequence).coercing_with(Integer) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:currency) }
  it { is_expected.to have_property(:items).coercing_with(Cashbox::Type.List(Cashbox::TransactionItem)) }
  it { is_expected.to have_property(:metadata) }
  it { is_expected.to have_property(:original_billing_date).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:payment_processor) }
  it { is_expected.to have_property(:payment_processor_transaction_id) }
  it { is_expected.to have_property(:shipping_address).coercing_with(Cashbox::Address) }
  it { is_expected.to have_property(:source_payment_method).coercing_with(Cashbox::PaymentMethod) }
  it { is_expected.to have_property(:status_log).coercing_with(Cashbox::Type.List(Cashbox::TransactionStatus)) }
  it { is_expected.to have_property(:sales_tax_address).coercing_with(Cashbox::Address) }
  it { is_expected.to have_property(:source_ip) }
  it { is_expected.to have_property(:sub_affiliate) }
  it { is_expected.to have_property(:subscription).coercing_with(Cashbox::Subscription) }
  it { is_expected.to have_property(:subscription_sequence) }
  it { is_expected.to have_property(:to_be_captured).coercing_with(Cashbox::Type.Boolean) }

  its(:object) { is_expected.to eql('Transaction') }

  describe "captured?" do
    let(:captured_status_list) { [Cashbox::TransactionStatus.new(status: 'Captured'), Cashbox::TransactionStatus.new(status: 'Settled')] }
    let(:settled_status_list) { [Cashbox::TransactionStatus.new(status: 'Pending'), Cashbox::TransactionStatus.new(status: 'Settled')] }
    let(:captured_status_transaction) { Cashbox::Transaction.new(status_log: captured_status_list) }
    let(:settled_status_transaction) { Cashbox::Transaction.new(status_log: settled_status_list) }
    let(:empty_status_transaction) { Cashbox::Transaction.new(status_log: []) }

    it "returns true when a transaction contains a Captured status" do
      expect(captured_status_transaction.captured?).to be true
    end

    it "returns false when a transaction does not contain a Captured status" do
      expect(settled_status_transaction.captured?).to be false
    end

    it "returns false when the status list is empty" do
      expect(empty_status_transaction.captured?).to be false
    end
  end

  describe "delegates" do
    let(:payment_method_credit_card) { Cashbox::PaymentMethod.new(type: "CreditCard", credit_card: { last_digits: 1234, bin: 321 }, account_holder: "test") }
    let(:payment_method_direct_debit) { Cashbox::PaymentMethod.new(type: "DirectDebit", direct_debit: { last_digits: 1234 }, account_holder: "test") }
    let(:transaction_cc) { Cashbox::Transaction.new(source_payment_method: payment_method_credit_card) }
    let(:transaction_dd) { Cashbox::Transaction.new(source_payment_method: payment_method_direct_debit) }

    it "returns the correct direct_debit payment method" do
      expect(transaction_dd.direct_debit.object).to eq("DirectDebit")
    end

    it "returns the correct credit_card payment method" do
      expect(transaction_cc.credit_card.object).to eq("CreditCard")
      expect(transaction_dd.direct_debit.object).to eq("DirectDebit")
    end

    it "returns the account_holder" do
      expect(transaction_dd.account_holder).to eq("test")
      expect(transaction_cc.account_holder).to eq("test")
    end

    it "returns the last digits of a payment method" do
      expect(transaction_dd.last_digits).to eq(1234)
      expect(transaction_cc.last_digits).to eq(1234)
    end

    it "#direct_debit?" do
      expect(transaction_dd.direct_debit?).to eq(true)
      expect(transaction_cc.direct_debit?).to eq(false)
    end

    it "#credit_card?" do
      expect(transaction_cc.credit_card?).to eq(true)
      expect(transaction_dd.credit_card?).to eq(false)
    end

    it "#card_network" do
      expect(transaction_cc.card_network).to eq("Visa")
      expect(transaction_dd.card_network).to eq(nil)
    end
  end
end
