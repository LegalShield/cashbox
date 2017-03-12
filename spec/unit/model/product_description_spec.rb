require 'spec_helper'

describe Vindicia::Model::ProductDescription do
  it { is_expected.to be_a(Vindicia::Model::Description) }

  its(:object) { is_expected.to eql('ProductDescription') }
end
