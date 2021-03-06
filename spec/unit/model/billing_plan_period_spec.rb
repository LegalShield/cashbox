require 'spec_helper'

describe Cashbox::BillingPlanPeriod do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  it { is_expected.to have_property(:cycles) }
  it { is_expected.to have_property(:quantity) }
  it { is_expected.to have_property(:type) }

  its(:object) { is_expected.to eql('BillingPlanPeriod') }
end
