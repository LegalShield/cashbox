module Cashbox
  class InvoiceItem < Model
    include Concern::Objectable

    property :id
    property :vid
    property :index_number
    property :type
    property :sku
    property :description
    property :quantity
    property :unit_amount
    property :tax_classification
    property :item_added, coerce: Cashbox::Type.DateTime
    property :item_removed, coerce: Cashbox::Type.DateTime
    property :item_serviceperiod_start, coerce: Cashbox::Type.DateTime
    property :item_serviceperiod_end, coerce: Cashbox::Type.DateTime
  end
end
