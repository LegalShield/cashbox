require 'spec_helper'

describe Vindicia::Account do
  it { is_expected.to be_a(Vindicia::Model) }
  it { is_expected.to be_a(Vindicia::Concern::Persistable) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:default_currency) }
  it { is_expected.to have_property(:email) }
  it { is_expected.to have_property(:email_type) }
  it { is_expected.to have_property(:language) }
  it { is_expected.to have_property(:metadata) }
  it { is_expected.to have_property(:notify_before_billing) }
  it { is_expected.to have_property(:name) }
  it { is_expected.to have_property(:payment_methods) }
  it { is_expected.to have_property(:shipping_address) }

  its(:object) { is_expected.to eql('Account') }
end
