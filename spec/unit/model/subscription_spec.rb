require 'spec_helper'

describe Cashbox::Subscription do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }
  it { is_expected.to be_a(Cashbox::Rest::Disentitle) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:account).coercing_with(Cashbox::Account) }
  it { is_expected.to have_property(:billing_day) }
  it { is_expected.to have_property(:billing_plan).coercing_with(Cashbox::BillingPlan) }
  it { is_expected.to have_property(:billing_state) }
  it { is_expected.to have_property(:balance) }
  it { is_expected.to have_property(:cancel_reason) }
  it { is_expected.to have_property(:currency) }
  it { is_expected.to have_property(:default_billing_plan).coercing_with(Cashbox::BillingPlan) }
  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:ends).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:entitled_through).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:items).coercing_with(Cashbox::Type.List(Cashbox::SubscriptionItem)) }
  it { is_expected.to have_property(:metadata).coercing_with(Cashbox::Metadata) }
  it { is_expected.to have_property(:message) }
  it { is_expected.to have_property(:minimum_commitment) }
  it { is_expected.to have_property(:most_recent_billing).coercing_with(Cashbox::Transaction) }
  it { is_expected.to have_property(:next_billing).coercing_with(Cashbox::Transaction) }
  it { is_expected.to have_property(:notify_on_transition).coercing_with(Cashbox::Type.Boolean) }
  it { is_expected.to have_property(:payment_method).coercing_with(Cashbox::PaymentMethod) }
  it { is_expected.to have_property(:policy) }
  it { is_expected.to have_property(:starts).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:status) }

  its(:object) { is_expected.to eql('Subscription') }


  describe "constants" do
    it "IN_RETRY is assigned to the correct value" do
      expect(Cashbox::Subscription::IN_RETRY).to eql("In Retry")
    end

    it "FAILED_TO_COLLECT is assigned to the correct value" do
      expect(Cashbox::Subscription::FAILED_TO_COLLECT).to eql("Failed To Collect")
    end

    it "GRACE_PERIOD is assigned to the correct value" do
      expect(Cashbox::Subscription::GRACE_PERIOD).to eql("Grace Period")
    end
  end
  
  context "billing state methods" do
    describe "in_retry?" do
      let(:subscription_retry) { Cashbox::Subscription.new(billing_state: Cashbox::Subscription::IN_RETRY) }
      let(:subscription_not_retry) { Cashbox::Subscription.new(billing_state: "Not") }

      it "returns true if subscription billing state is 'in retry'" do
        expect(subscription_retry.in_retry?).to be(true)
      end

      it "returns false if subscription billing state is not 'in retry'" do
        expect(subscription_not_retry.in_retry?).to be(false)
      end
    end

    describe "failed_to_collect?" do
      let(:subscription_failed) { Cashbox::Subscription.new(billing_state: Cashbox::Subscription::FAILED_TO_COLLECT) }
      let(:subscription_not_failed) { Cashbox::Subscription.new(billing_state: "Not") }

      it "returns true if subscription billing state is 'failed to collect'" do
        expect(subscription_failed.failed_to_collect?).to be(true)
      end

      it "returns false if subscription billing state is not 'failed to collect'" do
        expect(subscription_not_failed.failed_to_collect?).to be(false)
      end
    end

    describe "grace_period?" do
      let(:subscription_in_grace) { Cashbox::Subscription.new(billing_state: Cashbox::Subscription::GRACE_PERIOD) }
      let(:subscription_not_in_grace) { Cashbox::Subscription.new(billing_state: "Not") }

      it "returns true if subscription billing state is 'grace period'" do
        expect(subscription_in_grace.grace_period?).to be(true)
      end

      it "returns false if subscription billing state is not 'grace period'" do
        expect(subscription_not_in_grace.grace_period?).to be(false)
      end
    end
  end
 
  describe '#add_subscription_items' do
    
    subject { Cashbox::Subscription.new(id: 'sub_15', vid: 'sub_1235' ) }
    let!(:subscription_item_1) { Cashbox::SubscriptionItem.new(product: Cashbox::Product.new(id: "123")) }
    let!(:subscription_item_2) { Cashbox::SubscriptionItem.new(product: Cashbox::Product.new(id: "456")) }
    let(:request) { double('request', { response: 'my data' }) }
    let(:subscprition_items) { [subscription_item_1, subscription_item_2] }

    before do
      allow(subject.class).to receive(:cast)

      allow(Cashbox::Request).to receive(:new)
        .with(:post, '/subscriptions/sub_1235', 
        {
          query: { 
              effective_date: 'today',
              bill_prorated_period: true
          },
          body: {
              id: 'sub_15',
              items: subscprition_items
          }.to_json
         })
         .and_return(request)
      
         subject.add_subscription_items(subscprition_items, true)
    end

    it 'makes the correct api call to cashbox' do
      expect(Cashbox::Request).to have_received(:new)
        .with(:post, '/subscriptions/sub_1235', 
        {
          query: { 
              effective_date: 'today',
              bill_prorated_period: true
          },
          body: {
              id: 'sub_15',
              items: subscprition_items
          }.to_json
         })
    end

    it 'passes the response to cast correctly' do
      expect(subject.class).to have_received(:cast).with(subject, 'my data')
    end
  end
end
