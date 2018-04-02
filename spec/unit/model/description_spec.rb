require 'spec_helper'

describe Cashbox::Description do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:language) }

  its(:object) { is_expected.to eql('Description') }
end
