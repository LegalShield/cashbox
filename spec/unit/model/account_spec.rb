require 'spec_helper'

describe Vindicia::Model::Account do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:vid) }
  it { should have_property(:created).coercing_with(Vindicia::Type::DateTime) }
  it { should have_property(:default_currency) }
  it { should have_property(:email) }
  it { should have_property(:email_type) }
  it { should have_property(:name) }
  it { should have_property(:notify_before_billing) }
  it { should have_property(:payment_methods) }

  its(:object) { is_expected.to eql('Account') }
end
