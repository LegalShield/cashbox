require 'spec_helper'

describe Vindicia::Model::ProductPrice do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:amount).coercing_with(Float) }
  it { should have_property(:currency) }
end
