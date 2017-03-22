module Vindicia
  class Transaction < Model
    include Vindicia::Concern::Objectable

    property :id
    property :vid
    property :account, coerce: Vindicia::Account
    property :amount, coerce: Float
    property :billing_attempt, coerce: Integer
    property :billing_descriptor
    property :billing_plan_sequence, coerce: Integer
    property :created, coerce: Vindicia::Type.DateTime
    property :currency
    property :items, coerce: Vindicia::Type.List(Vindicia::TransactionItem)
    property :original_billing_date, coerce: Vindicia::Type.DateTime
    property :payment_processor
    property :payment_processor_transaction_id
    property :source_payment_method, coerce: Vindicia::PaymentMethod
    property :status_log, coerce: Vindicia::Type.List(Vindicia::TransactionStatus)
    property :subscription, coerce: Vindicia::Subscription
    property :subscription_sequence
    property :to_be_captured, coerce: Vindicia::Type.Boolean
  end
end
