require 'spec_helper'

describe Vindicia::Model::Subscription do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:vid) }
  it { should have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:account).coercing_with(Vindicia::Model::Account) }
  it { should have_property(:billing_day) }
  it { should have_property(:billing_plan).coercing_with(Vindicia::Model::BillingPlan) }
  it { should have_property(:billing_state) }
  it { should have_property(:currency) }
  it { should have_property(:default_billing_plan).coercing_with(Vindicia::Model::BillingPlan) }
  it { should have_property(:description) }
  it { should have_property(:ends).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:entitled_through).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:items) }
  it { should have_property(:most_recent_billing).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:next_billing).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:notify_on_transition).coercing_with(Vindicia::Type.Boolean) }
  it { should have_property(:payment_method).coercing_with(Vindicia::Model::PaymentMethod) }
  it { should have_property(:policy) }
  it { should have_property(:starts).coercing_with(Vindicia::Type.DateTime) }
end
