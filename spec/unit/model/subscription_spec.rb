require 'spec_helper'

describe Vindicia::Model::Subscription do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:account).coercing_with(Vindicia::Model::Account) }
  it { is_expected.to have_property(:billing_day) }
  it { is_expected.to have_property(:billing_plan).coercing_with(Vindicia::Model::BillingPlan) }
  it { is_expected.to have_property(:billing_state) }
  it { is_expected.to have_property(:currency) }
  it { is_expected.to have_property(:default_billing_plan).coercing_with(Vindicia::Model::BillingPlan) }
  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:ends).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:entitled_through).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:items) }
  it { is_expected.to have_property(:most_recent_billing).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:next_billing).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:notify_on_transition).coercing_with(Vindicia::Type.Boolean) }
  it { is_expected.to have_property(:payment_method).coercing_with(Vindicia::Model::PaymentMethod) }
  it { is_expected.to have_property(:policy) }
  it { is_expected.to have_property(:starts).coercing_with(Vindicia::Type.DateTime) }

  its(:object) { is_expected.to eql('Subscription') }
end
