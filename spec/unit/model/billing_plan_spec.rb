require 'spec_helper'

describe Vindicia::BillingPlan do
  it { is_expected.to be_a(Vindicia::Model) }
  it { is_expected.to be_a(Vindicia::Concern::Persistable) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:billing_descriptor) }
  it { is_expected.to have_property(:billing_notification_days) }
  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:message) }
  it { is_expected.to have_property(:periods) }
  it { is_expected.to have_property(:status) }

  its(:object) { is_expected.to eql('BillingPlan') }
end
