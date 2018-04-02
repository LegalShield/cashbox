require 'spec_helper'

describe Cashbox::PaymentMethod do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Persistable) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:credit_card).coercing_with(Cashbox::CreditCard) }
  it { is_expected.to have_property(:paypal).coercing_with(Cashbox::PayPal) }
  it { is_expected.to have_property(:primary) }
  it { is_expected.to have_property(:type) }

  its(:object) { is_expected.to eql('PaymentMethod') }
end
