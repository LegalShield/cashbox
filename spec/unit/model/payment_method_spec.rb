require 'spec_helper'

describe Vindicia::PaymentMethod do
  it { is_expected.to be_a(Vindicia::Model) }
  it { is_expected.to be_a(Vindicia::Concern::Persistable) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:credit_card).coercing_with(Vindicia::CreditCard) }
  it { is_expected.to have_property(:paypal).coercing_with(Vindicia::PayPal) }
  it { is_expected.to have_property(:primary) }
  it { is_expected.to have_property(:type) }

  its(:object) { is_expected.to eql('PaymentMethod') }
end
