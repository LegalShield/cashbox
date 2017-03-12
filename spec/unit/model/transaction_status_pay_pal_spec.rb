require 'spec_helper'

describe Vindicia::Model::TransactionStatusPayPal do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:token) }
  it { is_expected.to have_property(:auth_code) }
  it { is_expected.to have_property(:redirect_url) }
end
