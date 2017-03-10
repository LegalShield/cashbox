require 'spec_helper'

describe Vindicia::Model::BillingPlanPeriod do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:cycles) }
  it { should have_property(:quantity) }
  it { should have_property(:type) }
end

