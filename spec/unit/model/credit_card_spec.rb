require 'spec_helper'

describe Vindicia::Model::CreditCard do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:vid) }
  it { should have_property(:account) }
  it { should have_property(:bin) }
  it { should have_property(:last_digits) }
  it { should have_property(:account_length) }
  it { should have_property(:expiration_date) }
end
