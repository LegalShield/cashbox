require 'spec_helper'

describe Vindicia::Entitlement do
  it { is_expected.to be_a(Vindicia::Model) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:description) }

  its(:object) { is_expected.to eql('Entitlement') }
end
