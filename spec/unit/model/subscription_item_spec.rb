require 'spec_helper'

describe Vindicia::Model::SubscriptionItem do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:product).coercing_with(Vindicia::Model::Product) }
end
