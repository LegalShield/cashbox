require 'spec_helper'

describe Vindicia::CreditCard do
  it { is_expected.to be_a(Vindicia::Model) }

  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:account) }
  it { is_expected.to have_property(:bin) }
  it { is_expected.to have_property(:last_digits) }
  it { is_expected.to have_property(:account_length) }
  it { is_expected.to have_property(:expiration_date) }

  its(:object) { is_expected.to eql('CreditCard') }
end
