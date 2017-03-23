require 'spec_helper'

describe 'Transaction' do
  before { Vindicia.test!  }
  after { Vindicia.production! }

  describe 'first transaction' do
    subject do
      Vindicia::Transaction.first
    end

    before do
      stub_get('/transactions')
        .with({ query: { limit: 1 } })
        .to_return({
          :status => 200,
          :body => fixture('transactions'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it { is_expected.to be_a(Vindicia::Transaction) }

    its(:id)                               { is_expected.to eql('bbbbbbbbbbbbbbbb') }
    its(:vid)                              { is_expected.to eql('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa') }
    its(:account)                          { is_expected.to be_a(Vindicia::Account)  }
    its(:amount)                           { is_expected.to eql(10.71) }
    its(:billing_attempt)                  { is_expected.to eql(0) }
    its(:billing_descriptor)               { is_expected.to eql('1') }
    its(:billing_plan_sequence)            { is_expected.to eql(2) }
    its(:created)                          { is_expected.to eql(DateTime.parse('2017-02-11T00:01:35-08:00')) }
    its(:currency)                         { is_expected.to eql('USD') }
    its(:items)                            { is_expected.to be_an(Array) }
    its(:original_billing_date)            { is_expected.to eql(DateTime.parse('2017-02-11T00:00:00-08:00')) }
    its(:payment_processor)                { is_expected.to eql('PayPal') }
    its(:payment_processor_transaction_id) { is_expected.to eql("bbbbbbbbbbbbbbbb") }
    its(:source_payment_method)            { is_expected.to be_a(Vindicia::PaymentMethod) }
    its(:status_log)                       { is_expected.to be_an(Array) }
    its(:subscription)                     { is_expected.to be_a(Vindicia::Subscription)  }
    its(:subscription_sequence)            { is_expected.to eql(2) }
    its(:to_be_captured)                   { is_expected.to eql(nil) }

    it 'has items as Vindicia::TransactionItem' do
      expect(subject.items.first).to be_a(Vindicia::TransactionItem)
    end

    it 'has status log as Vindicia::TransactionStatus' do
      expect(subject.status_log.first).to be_a(Vindicia::TransactionStatus)
    end
  end
end
