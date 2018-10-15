require 'spec_helper'

describe Cashbox::SubscriptionItem do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:product).coercing_with(Cashbox::Product) }
  it { is_expected.to have_property(:index_number) }
  it { is_expected.to have_property(:replaces) }

  its(:object) { is_expected.to eql('SubscriptionItem') }
end
