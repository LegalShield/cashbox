require 'spec_helper'

describe Vindicia::Model::Address do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:vid) }
  it { should have_property(:name) }
  it { should have_property(:line1) }
  it { should have_property(:city) }
  it { should have_property(:district) }
  it { should have_property(:postal_code) }
  it { should have_property(:country) }
  it { should have_property(:phone) }
  it { should have_property(:fax) }

  its(:object) { is_expected.to eql('Address') }
end
