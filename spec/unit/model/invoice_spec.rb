require 'spec_helper'

describe Cashbox::Invoice do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Persistable) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }

  its(:object) { is_expected.to eql('Invoice') }
end

