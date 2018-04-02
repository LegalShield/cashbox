require 'spec_helper'

describe Cashbox::Price do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property(:amount).coercing_with(Float) }
  it { is_expected.to have_property(:currency) }

  its(:object) { is_expected.to eql('Price') }
end
