require 'spec_helper'

describe Vindicia::Model::TransactionStatus do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:payment_method_type) }
  it { is_expected.to have_property(:paypal_status).coercing_with(Vindicia::Model::TransactionStatusPayPal) }
  it { is_expected.to have_property(:status) }

end
