require 'spec_helper'

describe Cashbox::ProductDescription do
  it { is_expected.to be_a(Cashbox::Description) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  its(:object) { is_expected.to eql('ProductDescription') }
end
