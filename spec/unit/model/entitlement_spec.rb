require 'spec_helper'

describe Vindicia::Model::Entitlement do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:description) }
end
