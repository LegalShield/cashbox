require 'spec_helper'

describe Vindicia::ProductDescription do
  it { is_expected.to be_a(Vindicia::Description) }

  its(:object) { is_expected.to eql('ProductDescription') }
end
