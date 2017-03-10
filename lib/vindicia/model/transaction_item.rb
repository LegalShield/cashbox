module Vindicia::Model
  class TransactionItem < Base
    property :index_number
    property :item_type
    property :name
    property :quantity
    property :service_period_ends, coerce: Vindicia::Type::DateTime
    property :service_period_starts, coerce: Vindicia::Type::DateTime
    property :sku
    property :tax_classification
    property :tax_type
    property :total
  end
end
