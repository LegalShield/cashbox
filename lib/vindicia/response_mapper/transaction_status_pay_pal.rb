module Vindicia::ResponseMapper
  class TransactionStatusPayPal < Base
    def map(response)
      attributes = response.slice(:object, :token,
                                  :auth_code, :redirect_url)

      instance.update_attributes(attributes)
    end
  end
end

#{
    #"object"=>"TransactionStatusPayPal",
    #"token"=>"EC-0PY59464AS577883J",
    #"auth_code"=>"000",
    #"redirect_url"=>"https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&useraction=commit&token=EC-0PY59464AS577883J"
#}
