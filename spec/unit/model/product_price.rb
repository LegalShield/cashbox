require 'spec_helper'

describe Cashbox::ProductPrice do
  it { is_expected.to be_a(Cashbox::Price) }

  its(:object) { is_expected.to eql('ProductPrice') }
end
