require 'spec_helper'

describe Vindicia::ProductPrice do
  it { is_expected.to be_a(Vindicia::Price) }

  its(:object) { is_expected.to eql('ProductPrice') }
end
