require 'spec_helper'

describe Cashbox::InvoiceItem do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }

  its(:object) { is_expected.to eql('InvoiceItem') }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }

  it { is_expected.to have_property(:index_number) }
  it { is_expected.to have_property(:type) }
  it { is_expected.to have_property(:sku) }
  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:quantity) }
  it { is_expected.to have_property(:unit_amount) }
  it { is_expected.to have_property(:tax_classification) }
  it { is_expected.to have_property(:item_added).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:item_removed).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:item_serviceperiod_start).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:item_serviceperiod_end).coercing_with(Cashbox::Type.DateTime) }
end
