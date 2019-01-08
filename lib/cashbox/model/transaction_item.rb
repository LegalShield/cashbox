module Cashbox
  class TransactionItem < Model
    include Concern::Objectable

    property :index_number
    property :item_type
    property :name
    property :quantity
    property :replaces
    property :service_period_ends, coerce: Cashbox::Type.DateTime
    property :service_period_starts, coerce: Cashbox::Type.DateTime
    property :sku
    property :tax_classification
    property :tax_type
    property :total
    property :price
  end
end
