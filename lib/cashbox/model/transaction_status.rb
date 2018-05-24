module Cashbox
  class TransactionStatus < Model

    property :created, coerce: Cashbox::Type.DateTime
    property :payment_method_type
    property :paypal_status, coerce: Cashbox::TransactionStatusPayPal
    property :status
  end
end
