require 'spec_helper'

describe Vindicia::Price do
  it { is_expected.to be_a(Vindicia::Model) }

  it { is_expected.to have_property(:amount).coercing_with(Float) }
  it { is_expected.to have_property(:currency) }

  its(:object) { is_expected.to eql('Price') }
end
