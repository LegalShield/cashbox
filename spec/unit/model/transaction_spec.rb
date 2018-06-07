require 'spec_helper'

describe Cashbox::Transaction do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }
  it { is_expected.to be_a(Cashbox::Rest::Cancel) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:account).coercing_with(Cashbox::Account) }
  it { is_expected.to have_property(:affiliate) }
  it { is_expected.to have_property(:amount).coercing_with(Float) }
  it { is_expected.to have_property(:billing_attempt).coercing_with(Integer) }
  it { is_expected.to have_property(:billing_descriptor) }
  it { is_expected.to have_property(:billing_plan_sequence).coercing_with(Integer) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:currency) }
  it { is_expected.to have_property(:items).coercing_with(Cashbox::Type.List(Cashbox::TransactionItem)) }
  it { is_expected.to have_property(:metadata) }
  it { is_expected.to have_property(:original_billing_date).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:payment_processor) }
  it { is_expected.to have_property(:payment_processor_transaction_id) }
  it { is_expected.to have_property(:shipping_address).coercing_with(Cashbox::Address) }
  it { is_expected.to have_property(:source_payment_method).coercing_with(Cashbox::PaymentMethod) }
  it { is_expected.to have_property(:status_log).coercing_with(Cashbox::Type.List(Cashbox::TransactionStatus)) }
  it { is_expected.to have_property(:sales_tax_address).coercing_with(Cashbox::Address) }
  it { is_expected.to have_property(:source_ip) }
  it { is_expected.to have_property(:sub_affiliate) }
  it { is_expected.to have_property(:subscription).coercing_with(Cashbox::Subscription) }
  it { is_expected.to have_property(:subscription_sequence) }
  it { is_expected.to have_property(:to_be_captured).coercing_with(Cashbox::Type.Boolean) }

  its(:object) { is_expected.to eql('Transaction') }
end
