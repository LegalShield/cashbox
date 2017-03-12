require 'spec_helper'

describe Vindicia::Model::CreditCard do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:account) }
  it { is_expected.to have_property(:bin) }
  it { is_expected.to have_property(:last_digits) }
  it { is_expected.to have_property(:account_length) }
  it { is_expected.to have_property(:expiration_date) }
end
