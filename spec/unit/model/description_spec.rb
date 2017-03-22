require 'spec_helper'

describe Vindicia::Description do
  it { is_expected.to be_a(Vindicia::Model) }

  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:language) }

  its(:object) { is_expected.to eql('Description') }
end
