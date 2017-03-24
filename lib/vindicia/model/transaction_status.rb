module Vindicia
  class TransactionStatus < Model
    include Vindicia::Concern::Objectable

    property :created, coerce: Vindicia::Type.DateTime
    property :payment_method_type
    property :paypal_status, coerce: Vindicia::TransactionStatusPayPal
    property :status
  end
end
