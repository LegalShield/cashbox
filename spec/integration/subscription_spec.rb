require 'spec_helper'

describe 'Subscription' do
  before { Cashbox.test!  }
  after { Cashbox.production! }

  describe 'first transaction' do
    subject do
      Cashbox::Subscription.first
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

    it { is_expected.to be_a(Cashbox::Subscription) }

    its(:object)         { is_expected.to eql('Subscription') }
    its(:id)             { is_expected.to eql('8-1486761541') }
    its(:vid)            { is_expected.to eql('2297d68dbe0e4cc37aaf553c302af4b2bb20abbd') }
    its(:created)        { is_expected.to eql(DateTime.parse('2017-02-10T13:19:03-08:00')) }
    its(:account)        { is_expected.to be_a(Cashbox::Account)  }
    its(:billing_plan)   { is_expected.to be_a(Cashbox::BillingPlan) }
    its(:payment_method) { is_expected.to be_a(Cashbox::PaymentMethod) }
  end

  describe 'create subscription' do
    let(:subscription) do
      Cashbox::Subscription.new(
        metadata: {
          "vin:MandateFlag": "1",
          "vin:MandateVersion": "1.0",
          "vin:MandateBankName": "The Bank NA",
          "vin:MandateID": "1234123412341234"
        }
      )
    end

    let!(:stub) do
      stub_post('/subscriptions')
        .with({
          body: {
            object: 'Subscription',
            id: 'sub_1234',
            metadata: {
              "vin:MandateFlag": "1",
              "vin:MandateVersion": "1.0",
              "vin:MandateBankName": "The Bank NA",
              "vin:MandateID": "1234123412341234"
            }
          }.to_json
        }).to_return({
          :status => 200,
          :body => fixture('subscription'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    before do
      subscription.save
    end

    it 'makes the correct call' do
      expect(stub).to have_been_requested
    end
  end
end
