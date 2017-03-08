module Vindicia::ResponseMapper
  class Transaction < Base
    def map(response)
      attributes = response.slice(:object, :id, :vid, :created,
                                  :amount, :currency, :billing_descriptor,
                                  :subscription_sequence, :billing_plan_sequence,
                                  :payment_processor, :payment_processor_transaction_id,
                                  :original_billing_date, :billing_attempt, :to_be_captured)

      attributes[:amount]                = attributes[:amount].to_f               if attributes[:amount]
      attributes[:created]               = DateTime.parse(attributes[:created])   if attributes[:created]
      attributes[:account]               = _map(response[:account])               if response[:account]
      attributes[:source_payment_method] = _map(response[:source_payment_method]) if response[:source_payment_method]
      attributes[:subscription]          = _map(response[:subscription])          if response[:subscription]
      attributes[:status_log]            = _map(response[:status_log])            if response[:status_log]

      instance.update_attributes(attributes)
    end
  end
end
