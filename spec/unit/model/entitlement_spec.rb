require 'spec_helper'

describe Cashbox::Entitlement do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Rest::Basic) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:message) }

  its(:object) { is_expected.to eql('Entitlement') }
end
