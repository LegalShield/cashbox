require 'spec_helper'

describe Vindicia::SubscriptionItem do
  it { is_expected.to be_a(Vindicia::Model) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:product).coercing_with(Vindicia::Product) }

  its(:object) { is_expected.to eql('SubscriptionItem') }
end
