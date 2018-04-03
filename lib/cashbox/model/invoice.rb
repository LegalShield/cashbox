module Cashbox
  class Invoice < Model
    include Concern::Objectable
    include Concern::Persistable

    property :id
    property :vid
    property :billing_service_period_start, coerce: Cashbox::Type.DateTime
    property :billing_service_period_end, coerce: Cashbox::Type.DateTime
    property :due_date, coerce: Cashbox::Type.DateTime
    property :invoice_date, coerce: Cashbox::Type.DateTime
    property :status
    property :invoice_currency
    property :invoice_balance
    property :gross_charges_total
    property :tax_charges_total
    property :credit_total
    property :payments_received_total
    property :billing_sequence
    property :invoice_line_items, coerce: Cashbox::Type.List(Cashbox::InvoiceItem)
    property :invoice_tax_items, coerce: Cashbox::Type.List(Cashbox::InvoiceItem)
    property :invoice_payments, coerce: Cashbox::Type.List(Cashbox::Transaction)
    property :account, coerce: Cashbox::Account
    property :subscription, coerce: Cashbox::Subscription
  end
end
