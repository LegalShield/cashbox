require 'spec_helper'

describe Vindicia::Model::Product do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:vid) }
  it { should have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:descriptions) }
  it { should have_property(:status) }
  it { should have_property(:default_billing_plan).coercing_with(Vindicia::Model::BillingPlan) }
  it { should have_property(:entitlements) }
  it { should have_property(:billing_descriptor) }
  it { should have_property(:credit_granted) }
  it { should have_property(:prices) }
end
