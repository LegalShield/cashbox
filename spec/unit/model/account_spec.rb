require 'spec_helper'

describe Cashbox::Account do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::Basic) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:default_currency) }
  it { is_expected.to have_property(:email) }
  it { is_expected.to have_property(:email_type) }
  it { is_expected.to have_property(:language) }
  it { is_expected.to have_property(:notify_before_billing) }
  it { is_expected.to have_property(:name) }
  it { is_expected.to have_property(:payment_methods) }
  it { is_expected.to have_property(:shipping_address) }

  its(:object) { is_expected.to eql('Account') }
end
