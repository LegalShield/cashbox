require 'spec_helper'

describe Vindicia::Model::Price do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:amount) }
  it { should have_property(:currency) }
end
