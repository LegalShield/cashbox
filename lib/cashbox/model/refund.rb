module Cashbox
  class Transaction < Model
    include Concern::Objectable
    include Rest::ReadWrite
    include Rest::Cancel
    include Rest::Refund

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :transaction, coerce: Cashbox::Transaction
    property :refund_distribution_strategy
    property :amount, coerce: Float
    property :amount_includes_tax, coerce: Cashbox::Type.Boolean
    property :currency
    property :token_action
    property :status
  end
end
