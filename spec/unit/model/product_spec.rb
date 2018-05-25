require 'spec_helper'

describe Cashbox::Product do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:billing_descriptor) }
  it { is_expected.to have_property(:credit_granted) }
  it { is_expected.to have_property(:default_billing_plan).coercing_with(Cashbox::BillingPlan) }
  it { is_expected.to have_property(:descriptions).coercing_with(Cashbox::Type.List(Cashbox::ProductDescription)) }
  it { is_expected.to have_property(:entitlements).coercing_with(Cashbox::Type.List(Cashbox::Entitlement)) }
  it { is_expected.to have_property(:prices).coercing_with(Cashbox::Type.List(Cashbox::ProductPrice)) }
  it { is_expected.to have_property(:status) }

  its(:object) { is_expected.to eql('Product') }
end
