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
    it "GRACE_STATUSES contains expected values" do
      expect(Cashbox::Subscription::GRACE_STATUSES).to eql(%w[Retry Grace\ Period Failure\ to\ collect])
    end
  end

  describe "grace?" do
    let(:subscription_in_grace) { Cashbox::Subscription.new(billing_state: Cashbox::Subscription::GRACE_STATUSES[0]) }
    let(:subscription_not_in_grace) { Cashbox::Subscription.new(bililng_state: "Current") }

    it "returns true if subscription billing state is a grace / retry billing_state" do
      expect(subscription_in_grace.grace?).to be(true)
    end

    it "returns false if subscription billing state is not a grace / retry billing_state" do
      expect(subscription_not_in_grace.grace?).to be(false)
    end
  end
end
