require 'spec_helper'

describe Cashbox::PayPal do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property(:cancel_url) }
  it { is_expected.to have_property(:reference_id) }
  it { is_expected.to have_property(:request_reference_id) }
  it { is_expected.to have_property(:return_url) }

  its(:object) { is_expected.to eql('PayPal') }
end
