require 'spec_helper'

describe Cashbox::Product do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Persistable) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:descriptions) }
  it { is_expected.to have_property(:status) }
  it { is_expected.to have_property(:default_billing_plan).coercing_with(Cashbox::BillingPlan) }
  it { is_expected.to have_property(:entitlements) }
  it { is_expected.to have_property(:billing_descriptor) }
  it { is_expected.to have_property(:credit_granted) }
  it { is_expected.to have_property(:prices) }

  its(:object) { is_expected.to eql('Product') }
end
