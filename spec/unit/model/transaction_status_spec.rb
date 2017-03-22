require 'spec_helper'

describe Vindicia::TransactionStatus do
  it { is_expected.to be_a(Vindicia::Model) }

  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:payment_method_type) }
  it { is_expected.to have_property(:paypal_status).coercing_with(Vindicia::TransactionStatusPayPal) }
  it { is_expected.to have_property(:status) }

  its(:object) { is_expected.to eql('TransactionStatus') }
end
