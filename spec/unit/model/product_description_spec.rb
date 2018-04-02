require 'spec_helper'

describe Cashbox::ProductDescription do
  it { is_expected.to be_a(Cashbox::Description) }

  its(:object) { is_expected.to eql('ProductDescription') }
end
