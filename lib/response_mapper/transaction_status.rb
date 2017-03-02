module Vindicia::ResponseMapper
  class TransactionStatus < Base
    def map(response)
      attributes = response.slice(:object, :created, :status,
                                  :payment_method_type, :paypal_status)

      attributes[:created]       = DateTime.parse(attributes[:created]) if attributes[:created]
      attributes[:paypal_status] = _map(response[:paypal_status])       if response[:paypal_status]

      instance.update_attributes(attributes)
    end
  end
end

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
#}
