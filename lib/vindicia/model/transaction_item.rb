module Vindicia::Model
  class TransactionItem < Base
    property :index_number
    property :item_type
    property :name
    property :quantity
    property :service_period_ends, transform_with: lambda { |v| DateTime.parse(v) }
    property :service_period_starts, transform_with: lambda { |v| DateTime.parse(v) }
    property :sku
    property :tax_classification
    property :tax_type
    property :total
  end
end
