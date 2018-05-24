require 'spec_helper'

class TestBasicModel
  include Cashbox::Rest::Basic
end

describe TestBasicModel do
  it { is_expected.to be_a(Cashbox::Rest::Save) }
  it { is_expected.to be_a(Cashbox::Rest::Find) }
end
