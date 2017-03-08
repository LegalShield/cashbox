require 'spec_helper'

describe Vindicia::Model::ProductDescription do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_attr_accessor(:language) }
  it { should have_attr_accessor(:description) }
end

