require 'spec_helper'

describe Vindicia::Model::Price do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:amount).coercing_with(Float) }
  it { is_expected.to have_property(:currency) }
end
