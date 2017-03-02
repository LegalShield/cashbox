module Vindicia::Model
  class TransactionStatus < Base
    attr_accessor :object,
                  :created,
                  :status,
                  :payment_method_type,
                  :paypal_status
  end
end
