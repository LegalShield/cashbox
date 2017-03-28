require 'spec_helper'

describe 'Subscription' do
  before { Vindicia.test!  }
  after { Vindicia.production! }

  describe 'first transaction' do
    subject do
      Vindicia::Subscription.first
    end

    before do
      stub_get('/subscriptions')
        .with({ query: { limit: 1 } })
        .to_return({
          :status => 200,
          :body => fixture('subscriptions'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it { is_expected.to be_a(Vindicia::Subscription) }

    its(:object)         { is_expected.to eql('Subscription') }
    its(:id)             { is_expected.to eql('8-1486761541') }
    its(:vid)            { is_expected.to eql('2297d68dbe0e4cc37aaf553c302af4b2bb20abbd') }
    its(:created)        { is_expected.to eql(DateTime.parse('2017-02-10T13:19:03-08:00')) }
    its(:account)        { is_expected.to be_a(Vindicia::Account)  }
    its(:billing_plan)   { is_expected.to be_a(Vindicia::BillingPlan) }
    its(:payment_method) { is_expected.to be_a(Vindicia::PaymentMethod) }
  end
end
