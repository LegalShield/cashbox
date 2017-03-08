require 'spec_helper'

describe Vindicia::Model::BillingPlan do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_attr_accessor(:id) }
  it { should have_attr_accessor(:vid) }
  it { should have_attr_accessor(:created) }
  it { should have_attr_accessor(:billing_descriptor) }
  it { should have_attr_accessor(:billing_notification_days) }
  it { should have_attr_accessor(:description) }
  it { should have_attr_accessor(:periods) }
  it { should have_attr_accessor(:status) }
end
