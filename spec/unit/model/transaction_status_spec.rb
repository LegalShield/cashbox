require 'spec_helper'

describe Vindicia::Model::TransactionStatus do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:payment_method_type) }
  it { should have_property(:paypal_status).coercing_with(Vindicia::Model::TransactionStatusPayPal) }
  it { should have_property(:status) }

end
