module Cashbox
  class Transaction < Model
    include Cashbox::Concern::Objectable
    include Cashbox::Concern::Persistable

    property :id
    property :vid
    property :account, coerce: Cashbox::Account
    property :affiliate
    property :amount, coerce: Vindicia::Type.BigDecimal
    property :billing_attempt, coerce: Integer
    property :billing_descriptor
    property :billing_plan_sequence, coerce: Integer
    property :created, coerce: Cashbox::Type.DateTime
    property :currency
    property :items, coerce: Cashbox::Type.List(Cashbox::TransactionItem)
    property :metadata
    property :original_billing_date, coerce: Cashbox::Type.DateTime
    property :payment_processor
    property :payment_processor_transaction_id
    property :shipping_address, coerce: Cashbox::Address
    property :source_payment_method, coerce: Cashbox::PaymentMethod
    property :status_log, coerce: Cashbox::Type.List(Cashbox::TransactionStatus)
    property :sales_tax_address, coerce: Cashbox::Address
    property :source_ip
    property :sub_affiliate
    property :subscription, coerce: Cashbox::Subscription
    property :subscription_sequence
    property :to_be_captured, coerce: Cashbox::Type.Boolean
  end
end
