require 'spec_helper'

describe Cashbox::CreditCard do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:account) }
  it { is_expected.to have_property(:account_length) }
  it { is_expected.to have_property(:bin) }
  it { is_expected.to have_property(:expiration_date) }
  it { is_expected.to have_property(:last_digits) }

  its(:object) { is_expected.to eql('CreditCard') }
end
