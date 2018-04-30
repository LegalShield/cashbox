require 'spec_helper'

describe Cashbox::DirectDebit do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property(:account) }
  it { is_expected.to have_property(:account_length) }
  it { is_expected.to have_property(:bank_sort_code) }
  it { is_expected.to have_property(:country_code) }

  its(:object) { is_expected.to eql('DirectDebit') }
end
