require 'spec_helper'

describe Vindicia::Model::TransactionStatusPayPal do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:token) }
  it { should have_property(:auth_code) }
  it { should have_property(:redirect_url) }
end
