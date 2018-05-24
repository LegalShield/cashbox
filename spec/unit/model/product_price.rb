require 'spec_helper'

describe Cashbox::ProductPrice do
  it { is_expected.to be_a(Cashbox::Price) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  its(:object) { is_expected.to eql('ProductPrice') }
end
