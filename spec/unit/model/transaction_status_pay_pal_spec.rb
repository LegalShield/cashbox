require 'spec_helper'

describe Cashbox::TransactionStatusPayPal do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property(:token) }
  it { is_expected.to have_property(:auth_code) }
  it { is_expected.to have_property(:redirect_url) }

  its(:object) { is_expected.to eql('TransactionStatusPayPal') }
end
