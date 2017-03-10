require 'spec_helper'

describe Vindicia::Model::TransactionItem do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:index_number) }
  it { should have_property(:item_type) }
  it { should have_property(:name) }
  it { should have_property(:quantity) }
  it { should have_property(:service_period_ends).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:service_period_starts).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:sku) }
  it { should have_property(:tax_classification) }
  it { should have_property(:tax_type) }
  it { should have_property(:total) }
end
