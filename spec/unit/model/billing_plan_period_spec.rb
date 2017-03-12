require 'spec_helper'

describe Vindicia::Model::BillingPlanPeriod do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:cycles) }
  it { is_expected.to have_property(:quantity) }
  it { is_expected.to have_property(:type) }

  its(:object) { is_expected.to eql('BillingPlanPeriod') }
end
