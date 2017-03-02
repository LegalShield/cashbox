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


#{
    #"object"=>"Transaction",
    #"id"=>"LEGALSHI00000597",
    #"vid"=>"bc943d5f5458b8c13d3435dc52c7c23425bea41d",
    #"created"=>"2017-02-10T13:46:50-08:00",
    #"amount"=>0,
    #"currency"=>"USD",
    #"account"=>{
        #"object"=>"Account",
        #"id"=>"105-1486763198",
        #"vid"=>"570c2f4053ba985a5cbe19abb6fa7835906f9ce6",
        #"created"=>"2017-02-10T13:46:39-08:00",
        #"default_currency"=>"USD",
        #"email_type"=>"html",
        #"notify_before_billing"=>false,
        #"payment_methods"=>{
            #"object"=>"List",
            #"data"=>[
                #{
                    #"object"=>"PaymentMethod",
                    #"vid"=>"e7a75dcfa3df7f255a80089d535eff857ba070a7",
                    #"created"=>"2017-02-10T13:46:50-08:00",
                    #"type"=>"PayPal",
                    #"paypal"=>{
                        #"object"=>"PayPal",
                        #"return_url"=>"http://localhost:3000/success?test=1",
                        #"cancel_url"=>"http://localhost:3000/cancel",
                        #"request_reference_id"=>true,
                        #"reference_id"=>nil
                    #},
                    #"primary"=>true,
                    #"active"=>true
                #}
            #],
            #"total_count"=>1
        #}
    #},
    #"source_payment_method"=>{
        #"object"=>"PaymentMethod",
        #"vid"=>"e7a75dcfa3df7f255a80089d535eff857ba070a7",
        #"created"=>"2017-02-10T13:46:50-08:00",
        #"type"=>"PayPal",
        #"paypal"=>{
            #"object"=>"PayPal",
            #"return_url"=>"http://localhost:3000/success?test=1",
            #"cancel_url"=>"http://localhost:3000/cancel",
            #"request_reference_id"=>true,
            #"reference_id"=>nil
        #},
        #"primary"=>true,
        #"active"=>true
    #},
    #"status_log"=>{
        #"object"=>"List",
        #"data"=>[
            #{
                #"object"=>"TransactionStatus",
                #"status"=>"AuthorizationPending",
                #"created"=>"2017-02-10T13:46:52-08:00",
                #"payment_method_type"=>"PayPal",
                #"paypal_status"=>{
                    #"object"=>"TransactionStatusPayPal",
                    #"token"=>"EC-0PY59464AS577883J",
                    #"auth_code"=>"000",
                    #"redirect_url"=>"https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&useraction=commit&token=EC-0PY59464AS577883J"
                #}
            #},
            #{
                #"object"=>"TransactionStatus",
                #"status"=>"New",
                #"created"=>"2017-02-10T13:46:50-08:00",
                #"payment_method_type"=>"PayPal",
                #"paypal_status"=>{
                    #"object"=>"TransactionStatusPayPal",
                    #"token"=>"EC-0PY59464AS577883J",
                    #"auth_code"=>"000",
                    #"redirect_url"=>"https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&useraction=commit&token=EC-0PY59464AS577883J"
                #}
            #}
        #],
        #"total_count"=>2
    #},
    #"payment_processor"=>"PayPal",
    #"payment_processor_transaction_id"=>"LEGALSHI00000597",
    #"metadata"=>{
        #"vin:RetryNumber"=>"0",
        #"vin:BillingCycle"=>"0"
    #},
    #"items"=>{
        #"object"=>"List",
        #"data"=>[
            #{
                #"object"=>"TransactionItem",
                #"sku"=>"1",
                #"index_number"=>1,
                #"item_type"=>"Purchase",
                #"name"=>"daily",
                #"quantity"=>1,
                #"tax_classification"=>nil,
                #"service_period_starts"=>"2017-02-10T00:00:00-08:00",
                #"service_period_ends"=>"2017-02-10T00:00:00-08:00",
                #"tax_type"=>"Exclusive Sales",
                #"total"=>0
            #},
            #{
                #"object"=>"TransactionItem",
                #"sku"=>"6-1486763199",
                #"index_number"=>2,
                #"item_type"=>"Purchase",
                #"name"=>"Perseus Plan 1",
                #"quantity"=>1,
                #"tax_classification"=>nil,
                #"service_period_starts"=>"2017-02-10T00:00:00-08:00",
                #"service_period_ends"=>"2017-02-10T00:00:00-08:00",
                #"tax_type"=>"Exclusive Sales",
                #"total"=>0
            #},
            #{
                #"object"=>"TransactionItem",
                #"sku"=>"Total Tax",
                #"index_number"=>3,
                #"item_type"=>"Purchase",
                #"name"=>"Total Tax",
                #"price"=>0,
                #"quantity"=>1,
                #"tax_classification"=>"TaxExempt",
                #"service_period_starts"=>"2017-02-10T00:00:00-08:00",
                #"service_period_ends"=>"2017-02-10T00:00:00-08:00",
                #"tax_type"=>"Exclusive Sales",
                #"discount"=>0,
                #"subtotal"=>0,
                #"total"=>0
            #}
        #],
        #"total_count"=>3
    #},
    #"billing_descriptor"=>"1",
    #"subscription_sequence"=>1,
    #"billing_plan_sequence"=>1,
    #"original_billing_date"=>"2017-02-10T00:00:00-08:00",
    #"billing_attempt"=>0,
    #"subscription"=>{
        #"object"=>"Subscription",
        #"id"=>"16-1486763201",
        #"vid"=>"d8d7d43466be74b3c09d05dfd3f1ff5c9ab73e23"
    #},
    #"to_be_captured"=>true
#}


