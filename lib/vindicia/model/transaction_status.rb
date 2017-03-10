module Vindicia::Model
  class TransactionStatus < Base
    property :created, coerce: Vindicia::Type.DateTime
    property :payment_method_type
    property :paypal_status, coerce: Vindicia::Model::TransactionStatusPayPal
    property :status
  end
end
