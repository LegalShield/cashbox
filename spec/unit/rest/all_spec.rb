require 'spec_helper'

class TestBasicModel
  include Cashbox::Rest::All
end

describe TestBasicModel do
  it { is_expected.to be_a(Cashbox::Rest::Basic) }
  it { is_expected.to be_a(Cashbox::Rest::Archive) }
  it { is_expected.to be_a(Cashbox::Rest::Cancel) }
  it { is_expected.to be_a(Cashbox::Rest::Disentitle) }
end
