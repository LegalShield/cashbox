require 'spec_helper'

describe Vindicia::Model::PaymentMethod do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:vid) }
  it { should have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:credit_card).coercing_with(Vindicia::Model::CreditCard) }
  it { should have_property(:paypal).coercing_with(Vindicia::Model::PayPal) }
  it { should have_property(:primary) }
  it { should have_property(:type) }
end
