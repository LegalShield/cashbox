require 'spec_helper'

describe Vindicia::Model::BillingPlan do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:vid) }
  it { should have_property(:created).coercing_with(Vindicia::Type::DateTime) }
  it { should have_property(:billing_descriptor) }
  it { should have_property(:billing_notification_days) }
  it { should have_property(:description) }
  it { should have_property(:periods) }
  it { should have_property(:status) }
end
