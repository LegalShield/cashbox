module Vindicia::Model
  class TransactionStatus < Base
    property :created, transform_with: lambda { |v| DateTime.parse(v) }
    property :payment_method_type
    property :paypal_status, transform_with: lambda { |v| Vindicia::Model::TransactionStatusPayPal.new(v) }
    property :status
  end
end
