require 'spec_helper'

describe Vindicia::Model::TransactionItem do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:index_number) }
  it { is_expected.to have_property(:item_type) }
  it { is_expected.to have_property(:name) }
  it { is_expected.to have_property(:quantity) }
  it { is_expected.to have_property(:service_period_ends).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:service_period_starts).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:sku) }
  it { is_expected.to have_property(:tax_classification) }
  it { is_expected.to have_property(:tax_type) }
  it { is_expected.to have_property(:total) }
end
