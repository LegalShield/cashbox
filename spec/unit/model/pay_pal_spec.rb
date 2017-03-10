require 'spec_helper'

describe Vindicia::Model::PayPal do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:cancel_url) }
  it { should have_property(:reference_id) }
  it { should have_property(:request_reference_id) }
  it { should have_property(:return_url) }
end
