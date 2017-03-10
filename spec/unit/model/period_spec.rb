require 'spec_helper'

describe Vindicia::Model::Period do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:cycles) }
  it { should have_property(:quantity) }
  it { should have_property(:type) }
end
