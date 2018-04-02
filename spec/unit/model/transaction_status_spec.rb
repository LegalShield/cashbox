require 'spec_helper'

describe Cashbox::TransactionStatus do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:payment_method_type) }
  it { is_expected.to have_property(:paypal_status).coercing_with(Cashbox::TransactionStatusPayPal) }
  it { is_expected.to have_property(:status) }

  its(:object) { is_expected.to eql('TransactionStatus') }
end
