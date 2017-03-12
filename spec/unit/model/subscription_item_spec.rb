require 'spec_helper'

describe Vindicia::Model::SubscriptionItem do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:product).coercing_with(Vindicia::Model::Product) }

  its(:object) { is_expected.to eql('SubscriptionItem') }
end
