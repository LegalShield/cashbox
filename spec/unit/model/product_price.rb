require 'spec_helper'

describe Vindicia::Model::ProductPrice do
  it { is_expected.to be_a(Vindicia::Model::Price) }

  its(:object) { is_expected.to eql('ProductPrice') }
end
