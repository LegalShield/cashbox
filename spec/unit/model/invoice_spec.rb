require 'spec_helper'

describe Cashbox::Invoice do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }

  its(:object) { is_expected.to eql('Invoice') }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:billing_service_period_start).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:billing_service_period_end).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:due_date).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:invoice_date).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:status) }
  it { is_expected.to have_property(:invoice_currency) }
  it { is_expected.to have_property(:invoice_balance) }
  it { is_expected.to have_property(:gross_charges_total) }
  it { is_expected.to have_property(:tax_charges_total) }
  it { is_expected.to have_property(:credit_total) }
  it { is_expected.to have_property(:payments_received_total) }
  it { is_expected.to have_property(:billing_sequence) }
  it { is_expected.to have_property(:invoice_line_items).coercing_with(Cashbox::Type.List(Cashbox::InvoiceItem)) }
  it { is_expected.to have_property(:invoice_tax_items).coercing_with(Cashbox::Type.List(Cashbox::InvoiceItem)) }
  it { is_expected.to have_property(:invoice_payments).coercing_with(Cashbox::Type.List(Cashbox::Transaction)) }
  it { is_expected.to have_property(:account).coercing_with(Cashbox::Account) }
  it { is_expected.to have_property(:subscription).coercing_with(Cashbox::Subscription) }
end
