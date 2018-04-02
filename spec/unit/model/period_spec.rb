require 'spec_helper'

describe Cashbox::Period do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property(:cycles) }
  it { is_expected.to have_property(:quantity) }
  it { is_expected.to have_property(:type) }

  its(:object) { is_expected.to eql('Period') }
end
