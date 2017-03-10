require 'spec_helper'

describe Vindicia::Model::Description do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:description) }
  it { should have_property(:language) }
end
