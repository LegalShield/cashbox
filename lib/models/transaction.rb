module Vindicia::Model
  class Transaction < Base
    attr_accessor :object,
                  :id,
                  :vid,
                  :created,
                  :amount,
                  :currency,
                  :billing_descriptor,
                  :subscription_sequence,
                  :billing_plan_sequence,
                  :payment_processor,
                  :payment_processor_transaction_id,
                  :original_billing_date,
                  :billing_attempt,
                  :status_log,
                  :to_be_captured,
                  :amount,
                  :account,
                  :source_payment_method,
                  :subscription
  end
end
