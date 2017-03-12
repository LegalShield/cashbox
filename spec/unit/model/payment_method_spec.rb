require 'spec_helper'

describe Vindicia::Model::PaymentMethod do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:credit_card).coercing_with(Vindicia::Model::CreditCard) }
  it { is_expected.to have_property(:paypal).coercing_with(Vindicia::Model::PayPal) }
  it { is_expected.to have_property(:primary) }
  it { is_expected.to have_property(:type) }
end
