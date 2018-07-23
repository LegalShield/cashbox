require 'spec_helper'

describe Cashbox::Refund do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }
  it { is_expected.to be_a(Cashbox::Rest::Refund) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:transaction).coercing_with(Cashbox::Transaction) }
  it { is_expected.to have_property(:refund_distribution_strategy) }
  it { is_expected.to have_property(:amount) }
  it { is_expected.to have_property(:amount_includes_tax).coercing_with(Cashbox::Type.Boolean) }
  it { is_expected.to have_property(:currency) }
  it { is_expected.to have_property(:token_action) }
  it { is_expected.to have_property(:status) }

  its(:object) { is_expected.to eql('Refund') }
end
