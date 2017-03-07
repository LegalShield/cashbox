require 'spec_helper'

describe Vindicia::Model::Product do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_attr_accessor(:id) }
  it { should have_attr_accessor(:vid) }
  it { should have_attr_accessor(:created) }
  it { should have_attr_accessor(:descriptions) }
  it { should have_attr_accessor(:status) }
  it { should have_attr_accessor(:default_billing_plan) }
  it { should have_attr_accessor(:entitlements) }
  it { should have_attr_accessor(:billing_descriptor) }
  it { should have_attr_accessor(:credit_granted) }
  it { should have_attr_accessor(:prices) }

end
