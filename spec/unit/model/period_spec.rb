require 'spec_helper'

describe Vindicia::Model::Period do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:cycles) }
  it { is_expected.to have_property(:quantity) }
  it { is_expected.to have_property(:type) }
end
